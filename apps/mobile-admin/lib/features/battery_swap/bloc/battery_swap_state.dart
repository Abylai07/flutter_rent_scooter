part of 'battery_swap_bloc.dart';

sealed class BatterySwapState extends Equatable {
  const BatterySwapState();

  @override
  List<Object?> get props => [];
}

class BatterySwapInitial extends BatterySwapState {}

class BatterySwapLoading extends BatterySwapState {
  final BatterySwapReady? previousState;

  const BatterySwapLoading({this.previousState});

  @override
  List<Object?> get props => [previousState];
}

class BatterySwapReady extends BatterySwapState {
  final ScooterModel scooter;
  final BatteryModel currentBattery;
  final List<BatteryModel> availableBatteries;
  final BatteryModel? validatedBattery;

  const BatterySwapReady({
    required this.scooter,
    required this.currentBattery,
    required this.availableBatteries,
    this.validatedBattery,
  });

  @override
  List<Object?> get props => [
        scooter,
        currentBattery,
        availableBatteries,
        validatedBattery,
      ];
}

class BatterySwapInProgress extends BatterySwapState {
  final ScooterModel scooter;
  final BatteryModel currentBattery;
  final BatteryModel newBattery;
  final int elapsedSeconds;
  final SwapStep currentStep;

  const BatterySwapInProgress({
    required this.scooter,
    required this.currentBattery,
    required this.newBattery,
    required this.elapsedSeconds,
    required this.currentStep,
  });

  @override
  List<Object?> get props => [
        scooter,
        currentBattery,
        newBattery,
        elapsedSeconds,
        currentStep,
      ];
}

class BatterySwapProcessing extends BatterySwapState {
  final ScooterModel scooter;
  final BatteryModel oldBattery;
  final BatteryModel newBattery;

  const BatterySwapProcessing({
    required this.scooter,
    required this.oldBattery,
    required this.newBattery,
  });

  @override
  List<Object?> get props => [scooter, oldBattery, newBattery];
}

class BatterySwapCompleted extends BatterySwapState {
  final BatterySwapRecord swapRecord;
  final ScooterModel updatedScooter;
  final BatteryModel oldBattery;
  final BatteryModel newBattery;

  const BatterySwapCompleted({
    required this.swapRecord,
    required this.updatedScooter,
    required this.oldBattery,
    required this.newBattery,
  });

  @override
  List<Object?> get props => [swapRecord, updatedScooter, oldBattery, newBattery];
}

class BatterySwapError extends BatterySwapState {
  final String message;
  final BatterySwapReady? previousState;

  const BatterySwapError({
    required this.message,
    this.previousState,
  });

  @override
  List<Object?> get props => [message, previousState];
}

enum SwapStep {
  removingOld,
  installingNew,
  testing,
}
