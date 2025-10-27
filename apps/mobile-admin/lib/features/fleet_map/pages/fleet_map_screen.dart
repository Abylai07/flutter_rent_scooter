import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobility_hub_admin/features/fleet_map/bloc/fleet_map_bloc.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';
import 'package:mobility_hub_shared/core/models/maintenance/maintenance_task_model.dart';

class FleetMapScreen extends StatelessWidget {
  const FleetMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetMapBloc()
        ..add(const LoadFleetRequested())
        ..add(const StartAutoRefreshRequested()),
      child: const _FleetMapView(),
    );
  }
}

class _FleetMapView extends StatelessWidget {
  const _FleetMapView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterMenu(context),
          ),
          BlocBuilder<FleetMapBloc, FleetMapState>(
            builder: (context, state) {
              if (state is FleetMapLoaded && state.optimizedRoute != null) {
                return IconButton(
                  icon: const Icon(Icons.route, color: Colors.orange),
                  onPressed: () => _showOptimizedRoute(context, state.optimizedRoute!),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<FleetMapBloc, FleetMapState>(
        listener: (context, state) {
          if (state is FleetMapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is FleetMapLoading && state.previousState == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FleetMapLoaded) {
            return _buildFleetView(context, state);
          }

          if (state is FleetMapError && state.previousState != null) {
            return _buildFleetView(context, state.previousState!);
          }

          return const Center(child: Text('Loading fleet...'));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'optimize',
            onPressed: () {
              context.read<FleetMapBloc>().add(
                    const CalculateOptimalRouteRequested(),
                  );
            },
            child: const Icon(Icons.route),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: () {
              context.read<FleetMapBloc>().add(
                    const LoadFleetRequested(),
                  );
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildFleetView(BuildContext context, FleetMapLoaded state) {
    return Column(
      children: [
        _buildStatisticsPanel(state.statistics),
        Expanded(
          child: Stack(
            children: [
              // Map area with scooters
              Container(
                color: Colors.grey[100],
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.filteredScooters.length,
                  itemBuilder: (context, index) {
                    final scooter = state.filteredScooters[index];
                    final tasks = state.maintenanceTasks
                        .where((t) => t.scooterId == scooter.id)
                        .toList();
                    return _buildScooterCard(context, scooter, tasks, state);
                  },
                ),
              ),

              // Active route indicator
              if (state.activeRoute != null)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: _buildActiveRouteCard(state.activeRoute!),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsPanel(FleetStatistics stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Fleet',
                  '${stats.totalScooters}',
                  Icons.electric_scooter,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Available',
                  '${stats.availableScooters}',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'In Use',
                  '${stats.inUseScooters}',
                  Icons.directions_bike,
                  Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Maintenance',
                  '${stats.maintenanceNeeded}',
                  Icons.build,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Offline',
                  '${stats.offlineScooters}',
                  Icons.cloud_off,
                  Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Avg Battery',
                  '${stats.averageBatteryLevel.toInt()}%',
                  Icons.battery_charging_full,
                  Colors.teal,
                ),
              ),
            ],
          ),
          if (stats.pendingTasks > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    '${stats.pendingTasks} pending tasks, ${stats.inProgressTasks} in progress',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScooterCard(
    BuildContext context,
    ScooterModel scooter,
    List<MaintenanceTaskModel> tasks,
    FleetMapLoaded state,
  ) {
    final urgentTask = tasks.where((t) => t.priority == TaskPriority.urgent).firstOrNull;
    final isSelected = state.selectedScooter?.id == scooter.id;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Colors.blue[50] : null,
      child: InkWell(
        onTap: () {
          context.read<FleetMapBloc>().add(
                SelectScooterRequested(scooter: scooter),
              );
          _showScooterDetails(context, scooter, tasks);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Status indicator
              Container(
                width: 8,
                height: 60,
                decoration: BoxDecoration(
                  color: _getStatusColor(scooter.status),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),

              // Scooter icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getStatusColor(scooter.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.electric_scooter,
                  color: _getStatusColor(scooter.status),
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'SC-${scooter.deviceId}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(scooter.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            scooter.status.displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.battery_charging_full,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('${scooter.batteryLevel}%'),
                        const SizedBox(width: 16),
                        Icon(Icons.pedal_bike,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('${scooter.totalRidesCount} rides'),
                      ],
                    ),
                    if (tasks.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${tasks.length} task(s)',
                        style: TextStyle(
                          color: urgentTask != null ? Colors.red : Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Actions
              Column(
                children: [
                  if (urgentTask != null)
                    const Icon(Icons.priority_high, color: Colors.red, size: 24),
                  IconButton(
                    icon: const Icon(Icons.navigation),
                    onPressed: () {
                      context.read<FleetMapBloc>().add(
                            StartRouteToScooterRequested(scooter: scooter),
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveRouteCard(RouteInfo route) {
    return Card(
      color: Colors.blue[600],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.navigation, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Navigation Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'To SC-${route.destinationScooter.deviceId} • ${(route.distanceMeters / 1000).toStringAsFixed(1)} km • ~${route.estimatedTimeMinutes} min',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ScooterStatus status) {
    switch (status) {
      case ScooterStatus.available:
        return Colors.green;
      case ScooterStatus.inUse:
        return Colors.blue;
      case ScooterStatus.reserved:
        return Colors.orange;
      case ScooterStatus.maintenance:
        return Colors.red;
      case ScooterStatus.lowBattery:
        return Colors.deepOrange;
      case ScooterStatus.offline:
        return Colors.grey;
    }
  }

  void _showFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<FleetMapBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Fleet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.build, color: Colors.orange),
                title: const Text('Needs Maintenance'),
                onTap: () {
                  context.read<FleetMapBloc>().add(
                        const FilterByMaintenanceNeededRequested(
                          batteryThreshold: 20,
                          includeOffline: true,
                          includeMaintenance: true,
                        ),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.battery_alert, color: Colors.red),
                title: const Text('Low Battery (<20%)'),
                onTap: () {
                  context.read<FleetMapBloc>().add(
                        const FilterByMaintenanceNeededRequested(
                          batteryThreshold: 20,
                        ),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cloud_off, color: Colors.grey),
                title: const Text('Offline Scooters'),
                onTap: () {
                  context.read<FleetMapBloc>().add(
                        const FilterByStatusRequested(
                          statuses: [ScooterStatus.offline],
                        ),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.clear),
                title: const Text('Clear Filters'),
                onTap: () {
                  context.read<FleetMapBloc>().add(
                        const LoadFleetRequested(),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScooterDetails(
    BuildContext context,
    ScooterModel scooter,
    List<MaintenanceTaskModel> tasks,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.electric_scooter,
                    size: 40,
                    color: _getStatusColor(scooter.status),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scooter SC-${scooter.deviceId}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          scooter.status.displayName,
                          style: TextStyle(
                            color: _getStatusColor(scooter.status),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Battery Level', '${scooter.batteryLevel}%'),
              _buildDetailRow('Total Rides', '${scooter.totalRidesCount}'),
              _buildDetailRow('QR Code', scooter.qrCode),
              _buildDetailRow(
                'Rating',
                scooter.averageRating?.toStringAsFixed(1) ?? 'N/A',
              ),
              const SizedBox(height: 24),
              if (tasks.isNotEmpty) ...[
                const Text(
                  'Maintenance Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...tasks.map((task) => _buildTaskCard(task)),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to diagnostics
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text('Diagnostics'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to battery swap
                      },
                      icon: const Icon(Icons.battery_charging_full),
                      label: const Text('Swap Battery'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTaskCard(MaintenanceTaskModel task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          _getTaskIcon(task.type),
          color: _getPriorityColor(task.priority),
        ),
        title: Text(task.type.displayName),
        subtitle: Text(task.status.name),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getPriorityColor(task.priority).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            task.priority.name.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: _getPriorityColor(task.priority),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTaskIcon(MaintenanceType type) {
    switch (type) {
      case MaintenanceType.batterySwap:
        return Icons.battery_charging_full;
      case MaintenanceType.generalInspection:
        return Icons.search;
      case MaintenanceType.brakeRepair:
        return Icons.settings;
      case MaintenanceType.tireReplacement:
        return Icons.circle;
      case MaintenanceType.electronicsRepair:
        return Icons.electrical_services;
      case MaintenanceType.cleaning:
        return Icons.cleaning_services;
      case MaintenanceType.relocation:
        return Icons.location_on;
      case MaintenanceType.emergency:
        return Icons.emergency;
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.blue;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.deepOrange;
      case TaskPriority.urgent:
        return Colors.red;
    }
  }

  void _showOptimizedRoute(BuildContext context, List<ScooterModel> route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Optimal Route'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: route.length,
            itemBuilder: (context, index) {
              final scooter = route[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text('SC-${scooter.deviceId}'),
                subtitle: Text('Battery: ${scooter.batteryLevel}%'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Start navigation
            },
            child: const Text('Start Navigation'),
          ),
        ],
      ),
    );
  }
}
