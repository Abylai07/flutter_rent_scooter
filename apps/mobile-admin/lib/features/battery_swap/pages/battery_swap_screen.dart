import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobility_hub_admin/features/battery_swap/bloc/battery_swap_bloc.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';
import 'package:mobility_hub_shared/core/models/maintenance/battery_model.dart';

class BatterySwapScreen extends StatelessWidget {
  final ScooterModel scooter;

  const BatterySwapScreen({super.key, required this.scooter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BatterySwapBloc()
        ..add(LoadAvailableBatteriesRequested(
          scooter: scooter,
          scooterId: scooter.id,
        )),
      child: _BatterySwapView(scooter: scooter),
    );
  }
}

class _BatterySwapView extends StatelessWidget {
  final ScooterModel scooter;

  const _BatterySwapView({required this.scooter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Swap'),
        actions: [
          BlocBuilder<BatterySwapBloc, BatterySwapState>(
            builder: (context, state) {
              if (state is BatterySwapInProgress) {
                return TextButton(
                  onPressed: () {
                    context.read<BatterySwapBloc>().add(
                          const CancelBatterySwapRequested(),
                        );
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<BatterySwapBloc, BatterySwapState>(
        listener: (context, state) {
          if (state is BatterySwapCompleted) {
            _showCompletionDialog(context, state);
          } else if (state is BatterySwapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BatterySwapLoading && state.previousState == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BatterySwapReady) {
            return _buildReadyView(context, state);
          }

          if (state is BatterySwapInProgress) {
            return _buildInProgressView(context, state);
          }

          if (state is BatterySwapProcessing) {
            return _buildProcessingView(context, state);
          }

          if (state is BatterySwapError && state.previousState != null) {
            return _buildReadyView(context, state.previousState!);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildReadyView(BuildContext context, BatterySwapReady state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scooter info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.electric_scooter, size: 40, color: Colors.blue),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scooter SC-${scooter.deviceId}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'QR: ${scooter.qrCode}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Current battery section
          const Text(
            'Current Battery',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildBatteryCard(state.currentBattery, isCurrent: true),
          const SizedBox(height: 24),

          // Available batteries section
          const Text(
            'Available Batteries',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (state.availableBatteries.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text('No batteries available'),
                ),
              ),
            )
          else
            ...state.availableBatteries.map(
              (battery) => _buildBatteryCard(
                battery,
                isSelected: state.validatedBattery?.id == battery.id,
                onTap: () {
                  context.read<BatterySwapBloc>().add(
                        ValidateBatteryHealthRequested(battery: battery),
                      );
                },
                onSwap: state.validatedBattery?.id == battery.id
                    ? () {
                        context.read<BatterySwapBloc>().add(
                              StartBatterySwapRequested(newBattery: battery),
                            );
                      }
                    : null,
              ),
            ),

          const SizedBox(height: 24),

          // QR Scanner button
          OutlinedButton.icon(
            onPressed: () {
              _showQRScanner(context);
            },
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan Battery QR Code'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatteryCard(
    BatteryModel battery, {
    bool isCurrent = false,
    bool isSelected = false,
    VoidCallback? onTap,
    VoidCallback? onSwap,
  }) {
    return Card(
      color: isSelected ? Colors.blue[50] : null,
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Battery icon with charge level
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.battery_charging_full,
                        size: 60,
                        color: _getBatteryColor(battery.chargeLevel),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Text(
                          '${battery.chargeLevel}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  // Battery details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              battery.id,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isCurrent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'CURRENT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildBatteryInfo(
                              Icons.health_and_safety,
                              battery.health.name.toUpperCase(),
                              _getHealthColor(battery.health),
                            ),
                            const SizedBox(width: 12),
                            _buildBatteryInfo(
                              Icons.refresh,
                              '${battery.cycleCount} cycles',
                              Colors.grey[600]!,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildBatteryInfo(
                              Icons.bolt,
                              '${battery.voltage?.toStringAsFixed(1)}V',
                              Colors.grey[600]!,
                            ),
                            const SizedBox(width: 12),
                            _buildBatteryInfo(
                              Icons.thermostat,
                              '${battery.temperature?.toStringAsFixed(1)}°C',
                              Colors.grey[600]!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (onSwap != null) ...[
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: onSwap,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Start Battery Swap'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryInfo(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }

  Widget _buildInProgressView(BuildContext context, BatterySwapInProgress state) {
    final minutes = state.elapsedSeconds ~/ 60;
    final seconds = state.elapsedSeconds % 60;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress indicator
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: state.elapsedSeconds / 120,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.battery_charging_full,
                        size: 60, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Current step
          Text(
            _getStepTitle(state.currentStep),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _getStepDescription(state.currentStep),
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Steps checklist
          _buildStepItem(
            'Remove old battery',
            state.currentStep.index >= SwapStep.removingOld.index,
            state.currentStep == SwapStep.removingOld,
          ),
          _buildStepItem(
            'Install new battery',
            state.currentStep.index >= SwapStep.installingNew.index,
            state.currentStep == SwapStep.installingNew,
          ),
          _buildStepItem(
            'Test connection',
            state.currentStep.index >= SwapStep.testing.index,
            state.currentStep == SwapStep.testing,
          ),
          const SizedBox(height: 40),

          // Complete button
          if (state.elapsedSeconds >= 30)
            ElevatedButton(
              onPressed: () {
                context.read<BatterySwapBloc>().add(
                      const CompleteBatterySwapRequested(
                        technicianId: 'TECH001',
                      ),
                    );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
              child: const Text('Complete Swap'),
            ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String title, bool isCompleted, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCurrent ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingView(BuildContext context, BatterySwapProcessing state) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 24),
          Text(
            'Finalizing battery swap...',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Updating scooter status',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(SwapStep step) {
    switch (step) {
      case SwapStep.removingOld:
        return 'Removing Old Battery';
      case SwapStep.installingNew:
        return 'Installing New Battery';
      case SwapStep.testing:
        return 'Testing Connection';
    }
  }

  String _getStepDescription(SwapStep step) {
    switch (step) {
      case SwapStep.removingOld:
        return 'Carefully disconnect and remove the old battery';
      case SwapStep.installingNew:
        return 'Connect the new battery securely';
      case SwapStep.testing:
        return 'Verifying battery connection and charge';
    }
  }

  Color _getBatteryColor(int chargeLevel) {
    if (chargeLevel >= 80) return Colors.green;
    if (chargeLevel >= 50) return Colors.orange;
    return Colors.red;
  }

  Color _getHealthColor(BatteryHealth health) {
    switch (health) {
      case BatteryHealth.excellent:
        return Colors.green;
      case BatteryHealth.good:
        return Colors.lightGreen;
      case BatteryHealth.fair:
        return Colors.orange;
      case BatteryHealth.poor:
        return Colors.deepOrange;
      case BatteryHealth.critical:
        return Colors.red;
    }
  }

  void _showQRScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Battery QR'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Position QR code in the frame'),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Or enter battery ID',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                Navigator.pop(context);
                context.read<BatterySwapBloc>().add(
                      ScanBatteryQRRequested(batteryQRCode: value),
                    );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context, BatterySwapCompleted state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 12),
            Text('Swap Completed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow('Old Battery', state.oldBattery.id),
            _buildSummaryRow('New Battery', state.newBattery.id),
            _buildSummaryRow(
              'Duration',
              '${state.swapRecord.swapDurationSeconds! ~/ 60}:${(state.swapRecord.swapDurationSeconds! % 60).toString().padLeft(2, '0')}',
            ),
            _buildSummaryRow(
              'New Battery Level',
              '${state.newBattery.chargeLevel}%',
            ),
            const Divider(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.green),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Scooter is now ready for service'),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
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
