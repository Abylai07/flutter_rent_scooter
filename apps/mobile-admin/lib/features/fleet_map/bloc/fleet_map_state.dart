part of 'fleet_map_bloc.dart';

sealed class FleetMapState extends Equatable {
  const FleetMapState();

  @override
  List<Object?> get props => [];
}

class FleetMapInitial extends FleetMapState {}

class FleetMapLoading extends FleetMapState {
  final FleetMapLoaded? previousState;

  const FleetMapLoading({this.previousState});

  @override
  List<Object?> get props => [previousState];
}

class FleetMapLoaded extends FleetMapState {
  final List<ScooterModel> allScooters;
  final List<ScooterModel> filteredScooters;
  final List<MaintenanceTaskModel> maintenanceTasks;
  final Position technicianLocation;
  final FleetStatistics statistics;
  final ScooterModel? selectedScooter;
  final List<MaintenanceTaskModel>? selectedScooterTasks;
  final List<ScooterStatus>? activeStatusFilter;
  final FilterByMaintenanceNeededRequested? maintenanceFilter;
  final RouteInfo? activeRoute;
  final List<ScooterModel>? optimizedRoute;

  const FleetMapLoaded({
    required this.allScooters,
    required this.filteredScooters,
    required this.maintenanceTasks,
    required this.technicianLocation,
    required this.statistics,
    this.selectedScooter,
    this.selectedScooterTasks,
    this.activeStatusFilter,
    this.maintenanceFilter,
    this.activeRoute,
    this.optimizedRoute,
  });

  FleetMapLoaded copyWith({
    List<ScooterModel>? allScooters,
    List<ScooterModel>? filteredScooters,
    List<MaintenanceTaskModel>? maintenanceTasks,
    Position? technicianLocation,
    FleetStatistics? statistics,
    ScooterModel? selectedScooter,
    List<MaintenanceTaskModel>? selectedScooterTasks,
    List<ScooterStatus>? activeStatusFilter,
    FilterByMaintenanceNeededRequested? maintenanceFilter,
    RouteInfo? activeRoute,
    List<ScooterModel>? optimizedRoute,
  }) {
    return FleetMapLoaded(
      allScooters: allScooters ?? this.allScooters,
      filteredScooters: filteredScooters ?? this.filteredScooters,
      maintenanceTasks: maintenanceTasks ?? this.maintenanceTasks,
      technicianLocation: technicianLocation ?? this.technicianLocation,
      statistics: statistics ?? this.statistics,
      selectedScooter: selectedScooter,
      selectedScooterTasks: selectedScooterTasks,
      activeStatusFilter: activeStatusFilter ?? this.activeStatusFilter,
      maintenanceFilter: maintenanceFilter ?? this.maintenanceFilter,
      activeRoute: activeRoute,
      optimizedRoute: optimizedRoute,
    );
  }

  @override
  List<Object?> get props => [
        allScooters,
        filteredScooters,
        maintenanceTasks,
        technicianLocation,
        statistics,
        selectedScooter,
        selectedScooterTasks,
        activeStatusFilter,
        maintenanceFilter,
        activeRoute,
        optimizedRoute,
      ];
}

class FleetMapError extends FleetMapState {
  final String message;
  final FleetMapLoaded? previousState;

  const FleetMapError({
    required this.message,
    this.previousState,
  });

  @override
  List<Object?> get props => [message, previousState];
}

class FleetStatistics {
  final int totalScooters;
  final int availableScooters;
  final int inUseScooters;
  final int maintenanceNeeded;
  final int offlineScooters;
  final int pendingTasks;
  final int inProgressTasks;
  final double averageBatteryLevel;

  FleetStatistics({
    required this.totalScooters,
    required this.availableScooters,
    required this.inUseScooters,
    required this.maintenanceNeeded,
    required this.offlineScooters,
    required this.pendingTasks,
    required this.inProgressTasks,
    required this.averageBatteryLevel,
  });
}

class RouteInfo {
  final ScooterModel destinationScooter;
  final double distanceMeters;
  final int estimatedTimeMinutes;
  final DateTime startedAt;

  RouteInfo({
    required this.destinationScooter,
    required this.distanceMeters,
    required this.estimatedTimeMinutes,
    required this.startedAt,
  });
}
