part of 'ride_session_bloc.dart';

sealed class RideSessionState extends Equatable {
  const RideSessionState();

  @override
  List<Object?> get props => [];
}

class RideSessionInitial extends RideSessionState {}

class RideSessionLoading extends RideSessionState {
  final String? message;

  const RideSessionLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class RideSessionUnlocked extends RideSessionState {
  final int scooterId;

  const RideSessionUnlocked({required this.scooterId});

  @override
  List<Object?> get props => [scooterId];
}

class RideSessionActive extends RideSessionState {
  final RideSessionModel session;
  final double currentSpeed;
  final double estimatedCost;
  final List<String>? warnings;

  const RideSessionActive({
    required this.session,
    required this.currentSpeed,
    required this.estimatedCost,
    this.warnings,
  });

  @override
  List<Object?> get props => [session, currentSpeed, estimatedCost, warnings];
}

class RideSessionPaused extends RideSessionState {
  final RideSessionModel session;
  final DateTime pauseStartTime;

  const RideSessionPaused({
    required this.session,
    required this.pauseStartTime,
  });

  @override
  List<Object?> get props => [session, pauseStartTime];
}

class RideSessionCompleted extends RideSessionState {
  final RideSessionModel session;
  final RideSummary summary;

  const RideSessionCompleted({
    required this.session,
    required this.summary,
  });

  @override
  List<Object?> get props => [session, summary];
}

class RideSessionError extends RideSessionState {
  final String message;

  const RideSessionError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RideSummary {
  final int duration;
  final double distance;
  final double averageSpeed;
  final double totalCost;
  final double savings;

  RideSummary({
    required this.duration,
    required this.distance,
    required this.averageSpeed,
    required this.totalCost,
    required this.savings,
  });
}
