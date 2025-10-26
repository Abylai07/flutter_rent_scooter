part of 'ride_session_bloc.dart';

sealed class RideSessionEvent extends Equatable {
  const RideSessionEvent();

  @override
  List<Object?> get props => [];
}

class StartRideRequested extends RideSessionEvent {
  final int scooterId;
  final int userId;
  final int initialBatteryLevel;

  const StartRideRequested({
    required this.scooterId,
    required this.userId,
    required this.initialBatteryLevel,
  });

  @override
  List<Object?> get props => [scooterId, userId, initialBatteryLevel];
}

class PauseRideRequested extends RideSessionEvent {
  const PauseRideRequested();
}

class ResumeRideRequested extends RideSessionEvent {
  const ResumeRideRequested();
}

class EndRideRequested extends RideSessionEvent {
  const EndRideRequested();
}

class UpdateLocationRequested extends RideSessionEvent {
  final int? batteryLevel;

  const UpdateLocationRequested({this.batteryLevel});

  @override
  List<Object?> get props => [batteryLevel];
}

class RideTimerTick extends RideSessionEvent {
  const RideTimerTick();
}

class CheckRideLimitsRequested extends RideSessionEvent {
  const CheckRideLimitsRequested();
}

class UnlockScooterRequested extends RideSessionEvent {
  final int scooterId;
  final int userId;
  final int batteryLevel;

  const UnlockScooterRequested({
    required this.scooterId,
    required this.userId,
    required this.batteryLevel,
  });

  @override
  List<Object?> get props => [scooterId, userId, batteryLevel];
}
