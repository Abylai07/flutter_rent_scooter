part of 'fleet_map_bloc.dart';

sealed class FleetMapEvent extends Equatable {
  const FleetMapEvent();

  @override
  List<Object?> get props => [];
}

class LoadFleetRequested extends FleetMapEvent {
  final double areaRadiusKm;

  const LoadFleetRequested({this.areaRadiusKm = 10.0});

  @override
  List<Object?> get props => [areaRadiusKm];
}

class FilterByStatusRequested extends FleetMapEvent {
  final List<ScooterStatus> statuses;

  const FilterByStatusRequested({required this.statuses});

  @override
  List<Object?> get props => [statuses];
}

class FilterByMaintenanceNeededRequested extends FleetMapEvent {
  final int? batteryThreshold;
  final bool includeOffline;
  final bool includeMaintenance;

  const FilterByMaintenanceNeededRequested({
    this.batteryThreshold,
    this.includeOffline = true,
    this.includeMaintenance = true,
  });

  @override
  List<Object?> get props => [batteryThreshold, includeOffline, includeMaintenance];
}

class UpdateTechnicianLocationRequested extends FleetMapEvent {
  const UpdateTechnicianLocationRequested();
}

class SelectScooterRequested extends FleetMapEvent {
  final ScooterModel scooter;

  const SelectScooterRequested({required this.scooter});

  @override
  List<Object?> get props => [scooter];
}

class StartRouteToScooterRequested extends FleetMapEvent {
  final ScooterModel scooter;

  const StartRouteToScooterRequested({required this.scooter});

  @override
  List<Object?> get props => [scooter];
}

class CalculateOptimalRouteRequested extends FleetMapEvent {
  const CalculateOptimalRouteRequested();
}

class StartAutoRefreshRequested extends FleetMapEvent {
  final int intervalSeconds;

  const StartAutoRefreshRequested({this.intervalSeconds = 60});

  @override
  List<Object?> get props => [intervalSeconds];
}

class StopAutoRefreshRequested extends FleetMapEvent {
  const StopAutoRefreshRequested();
}
