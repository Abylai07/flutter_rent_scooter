import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobility_hub_shared/core/models/ride/ride_session_model.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';
import 'package:geolocator/geolocator.dart';

part 'ride_session_event.dart';
part 'ride_session_state.dart';

class RideSessionBloc extends Bloc<RideSessionEvent, RideSessionState> {
  Timer? _locationUpdateTimer;
  Timer? _rideTimer;
  Position? _lastPosition;
  double _totalDistance = 0.0;
  int _elapsedSeconds = 0;

  RideSessionBloc() : super(RideSessionInitial()) {
    on<StartRideRequested>(_onStartRide);
    on<PauseRideRequested>(_onPauseRide);
    on<ResumeRideRequested>(_onResumeRide);
    on<EndRideRequested>(_onEndRide);
    on<UpdateLocationRequested>(_onUpdateLocation);
    on<RideTimerTick>(_onRideTimerTick);
    on<CheckRideLimitsRequested>(_onCheckRideLimits);
    on<UnlockScooterRequested>(_onUnlockScooter);
  }

  Future<void> _onStartRide(
    StartRideRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    emit(RideSessionLoading());

    try {
      final position = await _getCurrentPosition();

      final session = RideSessionModel(
        id: DateTime.now().millisecondsSinceEpoch,
        scooterId: event.scooterId,
        userId: event.userId,
        startTime: DateTime.now().toIso8601String(),
        startLatitude: position.latitude,
        startLongitude: position.longitude,
        status: RideStatus.active,
        routePoints: [
          RideLocationPoint(
            latitude: position.latitude,
            longitude: position.longitude,
            timestamp: DateTime.now().toIso8601String(),
            speed: position.speed,
            batteryLevel: event.initialBatteryLevel,
          ),
        ],
      );

      _lastPosition = position;
      _totalDistance = 0.0;
      _elapsedSeconds = 0;

      _startLocationTracking();
      _startRideTimer();

      emit(RideSessionActive(
        session: session,
        currentSpeed: position.speed,
        estimatedCost: 0.0,
      ));
    } catch (e) {
      emit(RideSessionError(message: e.toString()));
    }
  }

  Future<void> _onPauseRide(
    PauseRideRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    if (state is! RideSessionActive) return;

    final currentState = state as RideSessionActive;

    _stopLocationTracking();
    _rideTimer?.cancel();

    emit(RideSessionPaused(
      session: currentState.session.copyWith(
        status: RideStatus.paused,
        pauseDurationMinutes: currentState.session.pauseDurationMinutes,
      ),
      pauseStartTime: DateTime.now(),
    ));
  }

  Future<void> _onResumeRide(
    ResumeRideRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    if (state is! RideSessionPaused) return;

    final currentState = state as RideSessionPaused;
    final pauseDuration = DateTime.now().difference(currentState.pauseStartTime).inMinutes;

    _startLocationTracking();
    _startRideTimer();

    emit(RideSessionActive(
      session: currentState.session.copyWith(
        status: RideStatus.active,
        pauseDurationMinutes: currentState.session.pauseDurationMinutes + pauseDuration,
      ),
      currentSpeed: 0.0,
      estimatedCost: _calculateCost(
        _elapsedSeconds ~/ 60,
        currentState.session.pauseDurationMinutes + pauseDuration,
      ),
    ));
  }

  Future<void> _onEndRide(
    EndRideRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    if (state is! RideSessionActive && state is! RideSessionPaused) return;

    _stopLocationTracking();
    _rideTimer?.cancel();

    final currentState = state is RideSessionActive
        ? (state as RideSessionActive).session
        : (state as RideSessionPaused).session;

    final position = await _getCurrentPosition();
    final totalMinutes = _elapsedSeconds ~/ 60;
    final totalCost = _calculateCost(totalMinutes, currentState.pauseDurationMinutes);

    final completedSession = currentState.copyWith(
      endTime: DateTime.now().toIso8601String(),
      endLatitude: position.latitude,
      endLongitude: position.longitude,
      status: RideStatus.completed,
      durationMinutes: totalMinutes,
      distanceKm: _totalDistance,
      totalCost: totalCost,
      averageSpeed: _totalDistance / (totalMinutes / 60),
    );

    emit(RideSessionCompleted(
      session: completedSession,
      summary: RideSummary(
        duration: totalMinutes,
        distance: _totalDistance,
        averageSpeed: completedSession.averageSpeed,
        totalCost: totalCost,
        savings: _calculateSavings(totalCost),
      ),
    ));
  }

  Future<void> _onUpdateLocation(
    UpdateLocationRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    if (state is! RideSessionActive) return;

    try {
      final position = await _getCurrentPosition();
      final currentState = state as RideSessionActive;

      if (_lastPosition != null) {
        final distance = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        _totalDistance += distance / 1000;
      }

      final updatedPoints = List<RideLocationPoint>.from(
        currentState.session.routePoints ?? [],
      )..add(
          RideLocationPoint(
            latitude: position.latitude,
            longitude: position.longitude,
            timestamp: DateTime.now().toIso8601String(),
            speed: position.speed,
            batteryLevel: event.batteryLevel,
          ),
        );

      _lastPosition = position;

      final updatedSession = currentState.session.copyWith(
        routePoints: updatedPoints,
        distanceKm: _totalDistance,
      );

      emit(RideSessionActive(
        session: updatedSession,
        currentSpeed: position.speed,
        estimatedCost: _calculateCost(
          _elapsedSeconds ~/ 60,
          updatedSession.pauseDurationMinutes,
        ),
      ));

      add(CheckRideLimitsRequested());
    } catch (e) {
      // Location update failed, continue ride
    }
  }

  void _onRideTimerTick(
    RideTimerTick event,
    Emitter<RideSessionState> emit,
  ) {
    if (state is! RideSessionActive) return;

    _elapsedSeconds++;
    final currentState = state as RideSessionActive;

    emit(RideSessionActive(
      session: currentState.session.copyWith(
        durationMinutes: _elapsedSeconds ~/ 60,
      ),
      currentSpeed: currentState.currentSpeed,
      estimatedCost: _calculateCost(
        _elapsedSeconds ~/ 60,
        currentState.session.pauseDurationMinutes,
      ),
    ));
  }

  void _onCheckRideLimits(
    CheckRideLimitsRequested event,
    Emitter<RideSessionState> emit,
  ) {
    if (state is! RideSessionActive) return;

    final currentState = state as RideSessionActive;
    final warnings = <String>[];

    if (_totalDistance > 45.0) {
      warnings.add('Approaching maximum ride distance (50 km)');
    }

    if (_elapsedSeconds > 420 * 60) {
      warnings.add('Ride duration exceeds 7 hours');
    }

    if (warnings.isNotEmpty) {
      emit(RideSessionActive(
        session: currentState.session,
        currentSpeed: currentState.currentSpeed,
        estimatedCost: currentState.estimatedCost,
        warnings: warnings,
      ));
    }
  }

  Future<void> _onUnlockScooter(
    UnlockScooterRequested event,
    Emitter<RideSessionState> emit,
  ) async {
    emit(RideSessionLoading(message: 'Unlocking scooter...'));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(RideSessionUnlocked(scooterId: event.scooterId));

      await Future.delayed(const Duration(milliseconds: 500));

      add(StartRideRequested(
        scooterId: event.scooterId,
        userId: event.userId,
        initialBatteryLevel: event.batteryLevel,
      ));
    } catch (e) {
      emit(RideSessionError(message: 'Failed to unlock scooter: ${e.toString()}'));
    }
  }

  void _startLocationTracking() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(UpdateLocationRequested()),
    );
  }

  void _stopLocationTracking() {
    _locationUpdateTimer?.cancel();
  }

  void _startRideTimer() {
    _rideTimer?.cancel();
    _rideTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(RideTimerTick()),
    );
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  double _calculateCost(int activeMinutes, int pauseMinutes) {
    const pricePerMinute = 0.5;
    final billableMinutes = activeMinutes - (pauseMinutes * 0.5).toInt();
    return (billableMinutes * pricePerMinute).clamp(0.0, double.infinity);
  }

  double _calculateSavings(double totalCost) {
    const averageTaxiCostPerKm = 2.5;
    final taxiCost = _totalDistance * averageTaxiCostPerKm;
    return (taxiCost - totalCost).clamp(0.0, double.infinity);
  }

  @override
  Future<void> close() {
    _locationUpdateTimer?.cancel();
    _rideTimer?.cancel();
    return super.close();
  }
}
