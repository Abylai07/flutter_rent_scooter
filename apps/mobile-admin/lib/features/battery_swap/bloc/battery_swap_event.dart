part of 'battery_swap_bloc.dart';

sealed class BatterySwapEvent extends Equatable {
  const BatterySwapEvent();

  @override
  List<Object?> get props => [];
}

class LoadAvailableBatteriesRequested extends BatterySwapEvent {
  final ScooterModel scooter;
  final int scooterId;

  const LoadAvailableBatteriesRequested({
    required this.scooter,
    required this.scooterId,
  });

  @override
  List<Object?> get props => [scooter, scooterId];
}

class StartBatterySwapRequested extends BatterySwapEvent {
  final BatteryModel newBattery;

  const StartBatterySwapRequested({required this.newBattery});

  @override
  List<Object?> get props => [newBattery];
}

class CompleteBatterySwapRequested extends BatterySwapEvent {
  final String technicianId;

  const CompleteBatterySwapRequested({required this.technicianId});

  @override
  List<Object?> get props => [technicianId];
}

class CancelBatterySwapRequested extends BatterySwapEvent {
  const CancelBatterySwapRequested();
}

class ScanBatteryQRRequested extends BatterySwapEvent {
  final String batteryQRCode;

  const ScanBatteryQRRequested({required this.batteryQRCode});

  @override
  List<Object?> get props => [batteryQRCode];
}

class ValidateBatteryHealthRequested extends BatterySwapEvent {
  final BatteryModel battery;

  const ValidateBatteryHealthRequested({required this.battery});

  @override
  List<Object?> get props => [battery];
}

class RecordSwapTimeRequested extends BatterySwapEvent {
  const RecordSwapTimeRequested();
}
