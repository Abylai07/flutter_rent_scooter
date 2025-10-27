import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobility_hub_app/src/features/ride/bloc/ride_session_bloc.dart';

class ActiveRideScreen extends StatelessWidget {
  const ActiveRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RideSessionBloc(),
      child: const _ActiveRideView(),
    );
  }
}

class _ActiveRideView extends StatelessWidget {
  const _ActiveRideView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RideSessionBloc, RideSessionState>(
        listener: (context, state) {
          if (state is RideSessionCompleted) {
            _showRideSummary(context, state);
          } else if (state is RideSessionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is RideSessionLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(state.message ?? 'Loading...'),
                ],
              ),
            );
          }

          if (state is RideSessionUnlocked) {
            return _buildUnlockedView(context);
          }

          if (state is RideSessionActive) {
            return _buildActiveRideView(context, state);
          }

          if (state is RideSessionPaused) {
            return _buildPausedRideView(context, state);
          }

          return _buildInitialView(context);
        },
      ),
    );
  }

  Widget _buildInitialView(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<RideSessionBloc>().add(
                UnlockScooterRequested(
                  scooterId: 1,
                  userId: 1,
                  batteryLevel: 85,
                ),
              );
        },
        child: const Text('Start Ride'),
      ),
    );
  }

  Widget _buildUnlockedView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          const Text(
            'Scooter Unlocked!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Starting your ride...'),
        ],
      ),
    );
  }

  Widget _buildActiveRideView(BuildContext context, RideSessionActive state) {
    final duration = Duration(minutes: state.session.durationMinutes);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return Stack(
      children: [
        // Map placeholder
        Container(
          color: Colors.grey[300],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map, size: 100, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Live Map',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),

        // Top stats card
        Positioned(
          top: 60,
          left: 16,
          right: 16,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        icon: Icons.timer,
                        label: 'Duration',
                        value: '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      ),
                      _buildStatItem(
                        icon: Icons.speed,
                        label: 'Speed',
                        value: '${state.currentSpeed.toStringAsFixed(1)} km/h',
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        icon: Icons.route,
                        label: 'Distance',
                        value: '${state.session.distanceKm.toStringAsFixed(2)} km',
                      ),
                      _buildStatItem(
                        icon: Icons.attach_money,
                        label: 'Cost',
                        value: '\$${state.estimatedCost.toStringAsFixed(2)}',
                        valueColor: Colors.green,
                      ),
                    ],
                  ),
                  if (state.warnings != null && state.warnings!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.warnings!.first,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // Bottom control buttons
        Positioned(
          bottom: 40,
          left: 16,
          right: 16,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<RideSessionBloc>().add(
                          const PauseRideRequested(),
                        );
                  },
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showEndRideConfirmation(context);
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text('End Ride'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPausedRideView(BuildContext context, RideSessionPaused state) {
    final pauseDuration = DateTime.now().difference(state.pauseStartTime);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pause_circle, size: 100, color: Colors.orange),
          const SizedBox(height: 24),
          const Text(
            'Ride Paused',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Paused for ${pauseDuration.inMinutes} minutes',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Distance: ${state.session.distanceKm.toStringAsFixed(2)} km',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () {
              context.read<RideSessionBloc>().add(
                    const ResumeRideRequested(),
                  );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Resume Ride'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              backgroundColor: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _showEndRideConfirmation(context);
            },
            child: const Text('End Ride'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  void _showEndRideConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('End Ride?'),
        content: const Text('Are you sure you want to end this ride?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<RideSessionBloc>().add(
                    const EndRideRequested(),
                  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('End Ride'),
          ),
        ],
      ),
    );
  }

  void _showRideSummary(BuildContext context, RideSessionCompleted state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Ride Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildSummaryRow('Duration', '${state.summary.duration} minutes'),
            _buildSummaryRow('Distance', '${state.summary.distance.toStringAsFixed(2)} km'),
            _buildSummaryRow('Avg Speed', '${state.summary.averageSpeed.toStringAsFixed(1)} km/h'),
            const Divider(height: 32),
            _buildSummaryRow(
              'Total Cost',
              '\$${state.summary.totalCost.toStringAsFixed(2)}',
              isHighlighted: true,
            ),
            _buildSummaryRow(
              'You Saved',
              '\$${state.summary.savings.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isHighlighted = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHighlighted ? 18 : 16,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlighted ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
