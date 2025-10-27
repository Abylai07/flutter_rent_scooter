import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_task_model.freezed.dart';
part 'maintenance_task_model.g.dart';

@freezed
class MaintenanceTaskModel with _$MaintenanceTaskModel {
  const factory MaintenanceTaskModel({
    required int id,
    required int scooterId,
    required MaintenanceType type,
    required TaskPriority priority,
    required TaskStatus status,
    required String createdAt,
    String? assignedToTechnicianId,
    String? scheduledFor,
    String? completedAt,
    required double scooterLatitude,
    required double scooterLongitude,
    String? notes,
    List<String>? issuesReported,
    MaintenanceResult? result,
  }) = _MaintenanceTaskModel;

  factory MaintenanceTaskModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceTaskModelFromJson(json);
}

@freezed
class MaintenanceResult with _$MaintenanceResult {
  const factory MaintenanceResult({
    required String completedAt,
    required String technicianId,
    required int durationMinutes,
    List<String>? partsReplaced,
    String? oldBatteryId,
    String? newBatteryId,
    int? batterySwapCount,
    String? diagnosticsReport,
    List<String>? photosUrls,
  }) = _MaintenanceResult;

  factory MaintenanceResult.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceResultFromJson(json);
}

enum MaintenanceType {
  @JsonValue('battery_swap')
  batterySwap,
  @JsonValue('general_inspection')
  generalInspection,
  @JsonValue('brake_repair')
  brakeRepair,
  @JsonValue('tire_replacement')
  tireReplacement,
  @JsonValue('electronics_repair')
  electronicsRepair,
  @JsonValue('cleaning')
  cleaning,
  @JsonValue('relocation')
  relocation,
  @JsonValue('emergency')
  emergency,
}

enum TaskPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum TaskStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('assigned')
  assigned,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

extension MaintenanceTypeX on MaintenanceType {
  String get displayName {
    switch (this) {
      case MaintenanceType.batterySwap:
        return 'Battery Swap';
      case MaintenanceType.generalInspection:
        return 'General Inspection';
      case MaintenanceType.brakeRepair:
        return 'Brake Repair';
      case MaintenanceType.tireReplacement:
        return 'Tire Replacement';
      case MaintenanceType.electronicsRepair:
        return 'Electronics Repair';
      case MaintenanceType.cleaning:
        return 'Cleaning';
      case MaintenanceType.relocation:
        return 'Relocation';
      case MaintenanceType.emergency:
        return 'Emergency';
    }
  }

  int get estimatedMinutes {
    switch (this) {
      case MaintenanceType.batterySwap:
        return 10;
      case MaintenanceType.generalInspection:
        return 20;
      case MaintenanceType.brakeRepair:
        return 30;
      case MaintenanceType.tireReplacement:
        return 25;
      case MaintenanceType.electronicsRepair:
        return 45;
      case MaintenanceType.cleaning:
        return 15;
      case MaintenanceType.relocation:
        return 5;
      case MaintenanceType.emergency:
        return 60;
    }
  }
}
