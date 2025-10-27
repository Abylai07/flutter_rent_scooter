import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';
import 'package:mobility_hub_shared/core/models/maintenance/maintenance_task_model.dart';

part 'fleet_map_event.dart';
part 'fleet_map_state.dart';

class FleetMapBloc extends Bloc<FleetMapEvent, FleetMapState> {
  Timer? _autoRefreshTimer;
  Position? _technicianLocation;

  FleetMapBloc() : super(FleetMapInitial()) {
    on<LoadFleetRequested>(_onLoadFleet);
    on<FilterByStatusRequested>(_onFilterByStatus);
    on<FilterByMaintenanceNeededRequested>(_onFilterByMaintenance);
    on<UpdateTechnicianLocationRequested>(_onUpdateTechnicianLocation);
    on<SelectScooterRequested>(_onSelectScooter);
    on<StartRouteToScooterRequested>(_onStartRoute);
    on<CalculateOptimalRouteRequested>(_onCalculateOptimalRoute);
    on<StartAutoRefreshRequested>(_onStartAutoRefresh);
    on<StopAutoRefreshRequested>(_onStopAutoRefresh);
  }

  Future<void> _onLoadFleet(
    LoadFleetRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    emit(FleetMapLoading());

    try {
      final position = await _getCurrentPosition();
      _technicianLocation = position;

      final scooters = await _fetchFleetData(event.areaRadiusKm);
      final maintenanceTasks = await _fetchMaintenanceTasks();

      final scootersWithIssues = scooters.where((s) =>
          s.status == ScooterStatus.maintenance ||
          s.status == ScooterStatus.lowBattery ||
          s.batteryLevel < 20).toList();

      final sortedScooters = _sortScootersByPriority(
        scootersWithIssues,
        maintenanceTasks,
        position,
      );

      emit(FleetMapLoaded(
        allScooters: scooters,
        filteredScooters: sortedScooters,
        maintenanceTasks: maintenanceTasks,
        technicianLocation: position,
        statistics: _calculateStatistics(scooters, maintenanceTasks),
      ));
    } catch (e) {
      emit(FleetMapError(message: e.toString()));
    }
  }

  Future<void> _onFilterByStatus(
    FilterByStatusRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    final currentState = state as FleetMapLoaded;

    final filtered = currentState.allScooters.where((scooter) {
      if (event.statuses.isEmpty) return true;
      return event.statuses.contains(scooter.status);
    }).toList();

    emit(currentState.copyWith(
      filteredScooters: filtered,
      activeStatusFilter: event.statuses,
    ));
  }

  Future<void> _onFilterByMaintenance(
    FilterByMaintenanceNeededRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    final currentState = state as FleetMapLoaded;

    final needsMaintenance = currentState.allScooters.where((scooter) {
      if (event.batteryThreshold != null && scooter.batteryLevel <= event.batteryThreshold!) {
        return true;
      }

      if (event.includeOffline && scooter.status == ScooterStatus.offline) {
        return true;
      }

      if (event.includeMaintenance && scooter.status == ScooterStatus.maintenance) {
        return true;
      }

      final hasPendingTask = currentState.maintenanceTasks.any(
        (task) => task.scooterId == scooter.id && task.status != TaskStatus.completed,
      );

      return hasPendingTask;
    }).toList();

    emit(currentState.copyWith(
      filteredScooters: needsMaintenance,
      maintenanceFilter: event,
    ));
  }

  Future<void> _onUpdateTechnicianLocation(
    UpdateTechnicianLocationRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    try {
      final position = await _getCurrentPosition();
      _technicianLocation = position;

      final currentState = state as FleetMapLoaded;

      emit(currentState.copyWith(technicianLocation: position));
    } catch (e) {
      // Continue with old location
    }
  }

  Future<void> _onSelectScooter(
    SelectScooterRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    final currentState = state as FleetMapLoaded;

    final relatedTasks = currentState.maintenanceTasks
        .where((task) => task.scooterId == event.scooter.id)
        .toList();

    emit(currentState.copyWith(
      selectedScooter: event.scooter,
      selectedScooterTasks: relatedTasks,
    ));
  }

  Future<void> _onStartRoute(
    StartRouteToScooterRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    final currentState = state as FleetMapLoaded;

    if (_technicianLocation == null) return;

    final distance = Geolocator.distanceBetween(
      _technicianLocation!.latitude,
      _technicianLocation!.longitude,
      event.scooter.latitude,
      event.scooter.longitude,
    );

    final estimatedTimeMinutes = (distance / 1000 / 4 * 60).round();

    emit(currentState.copyWith(
      activeRoute: RouteInfo(
        destinationScooter: event.scooter,
        distanceMeters: distance,
        estimatedTimeMinutes: estimatedTimeMinutes,
        startedAt: DateTime.now(),
      ),
    ));
  }

  Future<void> _onCalculateOptimalRoute(
    CalculateOptimalRouteRequested event,
    Emitter<FleetMapState> emit,
  ) async {
    if (state is! FleetMapLoaded) return;

    final currentState = state as FleetMapLoaded;

    emit(FleetMapLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final urgentTasks = currentState.maintenanceTasks
          .where((task) =>
              task.status == TaskStatus.pending &&
              (task.priority == TaskPriority.urgent || task.priority == TaskPriority.high))
          .toList();

      final scootersToVisit = urgentTasks.map((task) {
        return currentState.allScooters.firstWhere((s) => s.id == task.scooterId);
      }).toList();

      final optimizedRoute = _calculateTSP(scootersToVisit, _technicianLocation!);

      emit(currentState.copyWith(
        optimizedRoute: optimizedRoute,
      ));
    } catch (e) {
      emit(FleetMapError(
        message: 'Failed to calculate route',
        previousState: currentState,
      ));
    }
  }

  void _onStartAutoRefresh(
    StartAutoRefreshRequested event,
    Emitter<FleetMapState> emit,
  ) {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(
      Duration(seconds: event.intervalSeconds),
      (_) => add(LoadFleetRequested()),
    );
  }

  void _onStopAutoRefresh(
    StopAutoRefreshRequested event,
    Emitter<FleetMapState> emit,
  ) {
    _autoRefreshTimer?.cancel();
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<ScooterModel>> _fetchFleetData(double radiusKm) async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(30, (index) {
      final lat = 43.2220 + (index % 6 - 3) * 0.02;
      final lng = 76.8512 + (index ~/ 6 - 2) * 0.02;

      ScooterStatus status;
      if (index % 5 == 0) {
        status = ScooterStatus.lowBattery;
      } else if (index % 7 == 0) {
        status = ScooterStatus.maintenance;
      } else if (index % 11 == 0) {
        status = ScooterStatus.offline;
      } else {
        status = ScooterStatus.available;
      }

      return ScooterModel(
        id: index + 1,
        deviceId: 'SC${(2000 + index).toString()}',
        qrCode: 'QR${(20000 + index).toString()}',
        latitude: lat,
        longitude: lng,
        batteryLevel: index % 5 == 0 ? 15 : 50 + (index * 7) % 50,
        status: status,
        pricePerMinute: 0.5,
        totalRidesCount: 200 + index * 15,
        averageRating: 4.0 + (index % 10) * 0.1,
      );
    });
  }

  Future<List<MaintenanceTaskModel>> _fetchMaintenanceTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return List.generate(10, (index) {
      final types = MaintenanceType.values;
      final priorities = TaskPriority.values;

      return MaintenanceTaskModel(
        id: index + 1,
        scooterId: (index * 3) + 1,
        type: types[index % types.length],
        priority: priorities[index % priorities.length],
        status: index < 3 ? TaskStatus.pending : TaskStatus.assigned,
        createdAt: DateTime.now().subtract(Duration(hours: index)).toIso8601String(),
        scooterLatitude: 43.2220 + (index % 6 - 3) * 0.02,
        scooterLongitude: 76.8512 + (index ~/ 6 - 2) * 0.02,
        issuesReported: ['Battery low', 'Requires inspection'],
      );
    });
  }

  List<ScooterModel> _sortScootersByPriority(
    List<ScooterModel> scooters,
    List<MaintenanceTaskModel> tasks,
    Position techPosition,
  ) {
    final scootersWithScore = scooters.map((scooter) {
      int priority = 0;

      if (scooter.status == ScooterStatus.offline) priority += 100;
      if (scooter.batteryLevel < 10) priority += 80;
      if (scooter.batteryLevel < 20) priority += 50;
      if (scooter.status == ScooterStatus.maintenance) priority += 60;

      final hasUrgentTask = tasks.any(
        (task) => task.scooterId == scooter.id && task.priority == TaskPriority.urgent,
      );
      if (hasUrgentTask) priority += 90;

      final distance = Geolocator.distanceBetween(
        techPosition.latitude,
        techPosition.longitude,
        scooter.latitude,
        scooter.longitude,
      );

      final proximityScore = (1000 - (distance / 10)).clamp(0, 1000).toInt();

      return MapEntry(scooter, priority + proximityScore);
    }).toList();

    scootersWithScore.sort((a, b) => b.value.compareTo(a.value));

    return scootersWithScore.map((e) => e.key).toList();
  }

  FleetStatistics _calculateStatistics(
    List<ScooterModel> scooters,
    List<MaintenanceTaskModel> tasks,
  ) {
    final totalScooters = scooters.length;
    final available = scooters.where((s) => s.status == ScooterStatus.available).length;
    final inUse = scooters.where((s) => s.status == ScooterStatus.inUse).length;
    final needsMaintenance = scooters.where((s) =>
        s.status == ScooterStatus.maintenance ||
        s.status == ScooterStatus.lowBattery ||
        s.batteryLevel < 20).length;
    final offline = scooters.where((s) => s.status == ScooterStatus.offline).length;

    final pendingTasks = tasks.where((t) => t.status == TaskStatus.pending).length;
    final inProgressTasks = tasks.where((t) => t.status == TaskStatus.inProgress).length;

    final avgBattery = scooters.isEmpty
        ? 0.0
        : scooters.map((s) => s.batteryLevel).reduce((a, b) => a + b) / scooters.length;

    return FleetStatistics(
      totalScooters: totalScooters,
      availableScooters: available,
      inUseScooters: inUse,
      maintenanceNeeded: needsMaintenance,
      offlineScooters: offline,
      pendingTasks: pendingTasks,
      inProgressTasks: inProgressTasks,
      averageBatteryLevel: avgBattery,
    );
  }

  List<ScooterModel> _calculateTSP(List<ScooterModel> scooters, Position start) {
    if (scooters.isEmpty) return [];
    if (scooters.length == 1) return scooters;

    final visited = <ScooterModel>{};
    final route = <ScooterModel>[];
    var currentLat = start.latitude;
    var currentLng = start.longitude;

    while (visited.length < scooters.length) {
      ScooterModel? nearest;
      double minDistance = double.infinity;

      for (final scooter in scooters) {
        if (visited.contains(scooter)) continue;

        final distance = Geolocator.distanceBetween(
          currentLat,
          currentLng,
          scooter.latitude,
          scooter.longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearest = scooter;
        }
      }

      if (nearest != null) {
        visited.add(nearest);
        route.add(nearest);
        currentLat = nearest.latitude;
        currentLng = nearest.longitude;
      }
    }

    return route;
  }

  @override
  Future<void> close() {
    _autoRefreshTimer?.cancel();
    return super.close();
  }
}
