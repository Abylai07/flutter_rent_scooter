import 'package:freezed_annotation/freezed_annotation.dart';

part 'battery_model.freezed.dart';
part 'battery_model.g.dart';

@freezed
class BatteryModel with _$BatteryModel {
  const factory BatteryModel({
    required String id,
    required int chargeLevel,
    required int cycleCount,
    required BatteryHealth health,
    required BatteryStatus status,
    String? assignedToScooterId,
    required String manufacturingDate,
    String? lastChargedAt,
    double? voltage,
    double? temperature,
  }) = _BatteryModel;

  factory BatteryModel.fromJson(Map<String, dynamic> json) =>
      _$BatteryModelFromJson(json);
}

@freezed
class BatterySwapRecord with _$BatterySwapRecord {
  const factory BatterySwapRecord({
    required int id,
    required int scooterId,
    required String oldBatteryId,
    required String newBatteryId,
    required int oldBatteryLevel,
    required int newBatteryLevel,
    required String swappedAt,
    required String technicianId,
    required double latitude,
    required double longitude,
    int? swapDurationSeconds,
  }) = _BatterySwapRecord;

  factory BatterySwapRecord.fromJson(Map<String, dynamic> json) =>
      _$BatterySwapRecordFromJson(json);
}

enum BatteryHealth {
  @JsonValue('excellent')
  excellent,
  @JsonValue('good')
  good,
  @JsonValue('fair')
  fair,
  @JsonValue('poor')
  poor,
  @JsonValue('critical')
  critical,
}

enum BatteryStatus {
  @JsonValue('in_use')
  inUse,
  @JsonValue('charging')
  charging,
  @JsonValue('available')
  available,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('retired')
  retired,
}
