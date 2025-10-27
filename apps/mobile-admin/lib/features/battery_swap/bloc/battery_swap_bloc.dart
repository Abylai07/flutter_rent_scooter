import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobility_hub_shared/core/models/maintenance/battery_model.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';
import 'package:geolocator/geolocator.dart';

part 'battery_swap_event.dart';
part 'battery_swap_state.dart';

class BatterySwapBloc extends Bloc<BatterySwapEvent, BatterySwapState> {
  Timer? _swapTimer;
  DateTime? _swapStartTime;

  BatterySwapBloc() : super(BatterySwapInitial()) {
    on<LoadAvailableBatteriesRequested>(_onLoadAvailableBatteries);
    on<StartBatterySwapRequested>(_onStartBatterySwap);
    on<CompleteBatterySwapRequested>(_onCompleteBatterySwap);
    on<CancelBatterySwapRequested>(_onCancelBatterySwap);
    on<ScanBatteryQRRequested>(_onScanBatteryQR);
    on<ValidateBatteryHealthRequested>(_onValidateBatteryHealth);
    on<RecordSwapTimeRequested>(_onRecordSwapTime);
  }

  Future<void> _onLoadAvailableBatteries(
    LoadAvailableBatteriesRequested event,
    Emitter<BatterySwapState> emit,
  ) async {
    emit(BatterySwapLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final availableBatteries = await _fetchAvailableBatteries();
      final currentBattery = await _fetchCurrentBattery(event.scooterId);

      emit(BatterySwapReady(
        scooter: event.scooter,
        currentBattery: currentBattery,
        availableBatteries: availableBatteries,
      ));
    } catch (e) {
      emit(BatterySwapError(message: e.toString()));
    }
  }

  Future<void> _onStartBatterySwap(
    StartBatterySwapRequested event,
    Emitter<BatterySwapState> emit,
  ) async {
    if (state is! BatterySwapReady) return;

    final currentState = state as BatterySwapReady;

    _swapStartTime = DateTime.now();

    _swapTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(RecordSwapTimeRequested()),
    );

    emit(BatterySwapInProgress(
      scooter: currentState.scooter,
      currentBattery: currentState.currentBattery,
      newBattery: event.newBattery,
      elapsedSeconds: 0,
      currentStep: SwapStep.removingOld,
    ));
  }

  Future<void> _onCompleteBatterySwap(
    CompleteBatterySwapRequested event,
    Emitter<BatterySwapState> emit,
  ) async {
    if (state is! BatterySwapInProgress) return;

    final currentState = state as BatterySwapInProgress;

    _swapTimer?.cancel();

    emit(BatterySwapProcessing(
      scooter: currentState.scooter,
      oldBattery: currentState.currentBattery,
      newBattery: currentState.newBattery,
    ));

    try {
      final position = await _getCurrentPosition();

      final swapRecord = BatterySwapRecord(
        id: DateTime.now().millisecondsSinceEpoch,
        scooterId: currentState.scooter.id,
        oldBatteryId: currentState.currentBattery.id,
        newBatteryId: currentState.newBattery.id,
        oldBatteryLevel: currentState.currentBattery.chargeLevel,
        newBatteryLevel: currentState.newBattery.chargeLevel,
        swappedAt: DateTime.now().toIso8601String(),
        technicianId: event.technicianId,
        latitude: position.latitude,
        longitude: position.longitude,
        swapDurationSeconds: currentState.elapsedSeconds,
      );

      await Future.delayed(const Duration(seconds: 2));

      final updatedScooter = currentState.scooter.copyWith(
        batteryLevel: currentState.newBattery.chargeLevel,
        status: ScooterStatus.available,
      );

      emit(BatterySwapCompleted(
        swapRecord: swapRecord,
        updatedScooter: updatedScooter,
        oldBattery: currentState.currentBattery,
        newBattery: currentState.newBattery,
      ));
    } catch (e) {
      emit(BatterySwapError(
        message: 'Failed to complete battery swap: ${e.toString()}',
        previousState: state is BatterySwapReady ? state as BatterySwapReady : null,
      ));
    }
  }

  void _onCancelBatterySwap(
    CancelBatterySwapRequested event,
    Emitter<BatterySwapState> emit,
  ) {
    _swapTimer?.cancel();

    if (state is BatterySwapInProgress) {
      final currentState = state as BatterySwapInProgress;

      emit(BatterySwapReady(
        scooter: currentState.scooter,
        currentBattery: currentState.currentBattery,
        availableBatteries: [],
      ));
    } else {
      emit(BatterySwapInitial());
    }
  }

  Future<void> _onScanBatteryQR(
    ScanBatteryQRRequested event,
    Emitter<BatterySwapState> emit,
  ) async {
    if (state is! BatterySwapReady) return;

    final currentState = state as BatterySwapReady;

    emit(BatterySwapLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final scannedBattery = currentState.availableBatteries.firstWhere(
        (b) => b.id == event.batteryQRCode,
        orElse: () => throw Exception('Battery not found'),
      );

      add(ValidateBatteryHealthRequested(battery: scannedBattery));
    } catch (e) {
      emit(BatterySwapError(
        message: 'Invalid battery QR code',
        previousState: currentState,
      ));
    }
  }

  Future<void> _onValidateBatteryHealth(
    ValidateBatteryHealthRequested event,
    Emitter<BatterySwapState> emit,
  ) async {
    if (state is! BatterySwapLoading && state is! BatterySwapReady) return;

    final previousState = state is BatterySwapLoading
        ? (state as BatterySwapLoading).previousState
        : state as BatterySwapReady;

    if (previousState == null) return;

    try {
      if (event.battery.health == BatteryHealth.poor ||
          event.battery.health == BatteryHealth.critical) {
        emit(BatterySwapError(
          message: 'Battery health is too low for installation',
          previousState: previousState,
        ));
        return;
      }

      if (event.battery.chargeLevel < 80) {
        emit(BatterySwapError(
          message: 'Battery charge level below 80%',
          previousState: previousState,
        ));
        return;
      }

      if (event.battery.status != BatteryStatus.available) {
        emit(BatterySwapError(
          message: 'Battery is not available for swap',
          previousState: previousState,
        ));
        return;
      }

      emit(BatterySwapReady(
        scooter: previousState.scooter,
        currentBattery: previousState.currentBattery,
        availableBatteries: previousState.availableBatteries,
        validatedBattery: event.battery,
      ));
    } catch (e) {
      emit(BatterySwapError(
        message: 'Battery validation failed',
        previousState: previousState,
      ));
    }
  }

  void _onRecordSwapTime(
    RecordSwapTimeRequested event,
    Emitter<BatterySwapState> emit,
  ) {
    if (state is! BatterySwapInProgress) return;

    final currentState = state as BatterySwapInProgress;
    final elapsed = DateTime.now().difference(_swapStartTime!).inSeconds;

    SwapStep step = currentState.currentStep;
    if (elapsed > 30 && elapsed <= 60) {
      step = SwapStep.installingNew;
    } else if (elapsed > 60) {
      step = SwapStep.testing;
    }

    emit(BatterySwapInProgress(
      scooter: currentState.scooter,
      currentBattery: currentState.currentBattery,
      newBattery: currentState.newBattery,
      elapsedSeconds: elapsed,
      currentStep: step,
    ));
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<BatteryModel>> _fetchAvailableBatteries() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(5, (index) {
      return BatteryModel(
        id: 'BAT${(5000 + index).toString()}',
        chargeLevel: 85 + (index * 3),
        cycleCount: 50 + (index * 20),
        health: index < 4 ? BatteryHealth.good : BatteryHealth.excellent,
        status: BatteryStatus.available,
        manufacturingDate: '2024-01-01',
        lastChargedAt: DateTime.now().subtract(Duration(hours: index)).toIso8601String(),
        voltage: 48.0 + (index * 0.5),
        temperature: 25.0 + (index * 2),
      );
    });
  }

  Future<BatteryModel> _fetchCurrentBattery(int scooterId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const BatteryModel(
      id: 'BAT4999',
      chargeLevel: 15,
      cycleCount: 450,
      health: BatteryHealth.fair,
      status: BatteryStatus.inUse,
      manufacturingDate: '2023-06-15',
      voltage: 45.2,
      temperature: 32.0,
    );
  }

  @override
  Future<void> close() {
    _swapTimer?.cancel();
    return super.close();
  }
}
