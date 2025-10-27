import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobility_hub_app/src/features/scooter_map/bloc/scooter_map_bloc.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';

class ScooterMapScreen extends StatelessWidget {
  const ScooterMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScooterMapBloc()
        ..add(const LoadScootersRequested())
        ..add(const StartAutoRefreshRequested()),
      child: const _ScooterMapView(),
    );
  }
}

class _ScooterMapView extends StatelessWidget {
  const _ScooterMapView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Scooter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ScooterMapBloc>().add(
                    const LoadScootersRequested(),
                  );
            },
          ),
        ],
      ),
      body: BlocConsumer<ScooterMapBloc, ScooterMapState>(
        listener: (context, state) {
          if (state is ScooterMapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ScooterMapLoading && state.previousState == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ScooterMapLoaded) {
            return _buildMapView(context, state);
          }

          if (state is ScooterMapError && state.previousState != null) {
            return _buildMapView(context, state.previousState!);
          }

          return const Center(child: Text('Loading scooters...'));
        },
      ),
      floatingActionButton: BlocBuilder<ScooterMapBloc, ScooterMapState>(
        builder: (context, state) {
          if (state is ScooterMapLoaded && state.selectedScooter != null) {
            return FloatingActionButton.extended(
              onPressed: () {
                _showScooterDetails(context, state.selectedScooter!);
              },
              icon: const Icon(Icons.electric_scooter),
              label: const Text('View Details'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMapView(BuildContext context, ScooterMapLoaded state) {
    return Column(
      children: [
        _buildSearchBar(context),
        _buildStatsBar(state),
        Expanded(
          child: Stack(
            children: [
              // Map placeholder with scooters
              Container(
                color: Colors.grey[200],
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.filteredScooters.length,
                  itemBuilder: (context, index) {
                    final scooter = state.filteredScooters[index];
                    return _buildScooterMarker(context, scooter, state);
                  },
                ),
              ),

              // Selected scooter card
              if (state.selectedScooter != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: _buildSelectedScooterCard(context, state),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by ID or QR code',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (query) {
          context.read<ScooterMapBloc>().add(
                SearchScootersRequested(query: query),
              );
        },
      ),
    );
  }

  Widget _buildStatsBar(ScooterMapLoaded state) {
    final available = state.filteredScooters
        .where((s) => s.status == ScooterStatus.available)
        .length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatChip(
            icon: Icons.electric_scooter,
            label: 'Total',
            value: '${state.filteredScooters.length}',
          ),
          _buildStatChip(
            icon: Icons.check_circle,
            label: 'Available',
            value: '$available',
            color: Colors.green,
          ),
          if (state.reservedScooterId != null)
            _buildStatChip(
              icon: Icons.bookmark,
              label: 'Reserved',
              value: '1',
              color: Colors.orange,
            ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? Colors.blue),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildScooterMarker(
    BuildContext context,
    ScooterModel scooter,
    ScooterMapLoaded state,
  ) {
    final isSelected = state.selectedScooter?.id == scooter.id;
    final isFavorite = state.favoriteScooterIds.contains(scooter.id);

    return GestureDetector(
      onTap: () {
        context.read<ScooterMapBloc>().add(
              SelectScooterRequested(scooter: scooter),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getScooterColor(scooter.status),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.electric_scooter,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${scooter.batteryLevel}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (isFavorite)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.star, size: 16, color: Colors.yellow),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedScooterCard(BuildContext context, ScooterMapLoaded state) {
    final scooter = state.selectedScooter!;
    final isReserved = state.reservedScooterId == scooter.id;

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getScooterColor(scooter.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.electric_scooter,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scooter #${scooter.deviceId}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        scooter.status.displayName,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    state.favoriteScooterIds.contains(scooter.id)
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    context.read<ScooterMapBloc>().add(
                          ToggleFavoriteScooterRequested(scooterId: scooter.id),
                        );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.battery_charging_full,
                  label: '${scooter.batteryLevel}%',
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.attach_money,
                  label: '\$${scooter.pricePerMinute}/min',
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.star,
                  label: scooter.averageRating?.toStringAsFixed(1) ?? 'N/A',
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (scooter.status.canBeRented && !isReserved)
              ElevatedButton(
                onPressed: () {
                  context.read<ScooterMapBloc>().add(
                        ReserveScooterRequested(scooterId: scooter.id),
                      );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Reserve (15 min)'),
              )
            else if (isReserved)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<ScooterMapBloc>().add(
                              const CancelReservationRequested(),
                            );
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to ride screen
                      },
                      child: const Text('Start Ride'),
                    ),
                  ),
                ],
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('This scooter is not available'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Color _getScooterColor(ScooterStatus status) {
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

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ScooterMapBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Scooters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                title: const Text('Only Available'),
                value: true,
                onChanged: (value) {
                  context.read<ScooterMapBloc>().add(
                        FilterScootersRequested(
                          onlyAvailable: value ?? false,
                          minBattery: 20,
                        ),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                title: const Text('Min Battery: 20%'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.read<ScooterMapBloc>().add(
                        const FilterScootersRequested(minBattery: 20),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                title: const Text('Within 1 km'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.read<ScooterMapBloc>().add(
                        const FilterScootersRequested(maxDistance: 1.0),
                      );
                  Navigator.pop(sheetContext);
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<ScooterMapBloc>().add(
                        const LoadScootersRequested(),
                      );
                  Navigator.pop(sheetContext);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Clear Filters'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScooterDetails(BuildContext context, ScooterModel scooter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Scooter #${scooter.deviceId}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('QR Code', scooter.qrCode),
            _buildDetailRow('Battery', '${scooter.batteryLevel}%'),
            _buildDetailRow('Status', scooter.status.displayName),
            _buildDetailRow('Price', '\$${scooter.pricePerMinute}/min'),
            _buildDetailRow('Total Rides', '${scooter.totalRidesCount}'),
            _buildDetailRow(
              'Rating',
              scooter.averageRating?.toStringAsFixed(1) ?? 'N/A',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
