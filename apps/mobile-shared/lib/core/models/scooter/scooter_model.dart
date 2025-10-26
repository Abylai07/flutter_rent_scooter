import 'package:freezed_annotation/freezed_annotation.dart';

part 'scooter_model.freezed.dart';
part 'scooter_model.g.dart';

@freezed
class ScooterModel with _$ScooterModel {
  const factory ScooterModel({
    required int id,
    required String deviceId,
    required String qrCode,
    required double latitude,
    required double longitude,
    required int batteryLevel,
    required ScooterStatus status,
    required double pricePerMinute,
    String? lastMaintenanceDate,
    int? totalRidesCount,
    double? averageRating,
  }) = _ScooterModel;

  factory ScooterModel.fromJson(Map<String, dynamic> json) =>
      _$ScooterModelFromJson(json);
}

enum ScooterStatus {
  @JsonValue('available')
  available,
  @JsonValue('in_use')
  inUse,
  @JsonValue('reserved')
  reserved,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('low_battery')
  lowBattery,
  @JsonValue('offline')
  offline,
}

extension ScooterStatusX on ScooterStatus {
  bool get isAvailable => this == ScooterStatus.available;
  bool get canBeRented => this == ScooterStatus.available || this == ScooterStatus.reserved;

  String get displayName {
    switch (this) {
      case ScooterStatus.available:
        return 'Available';
      case ScooterStatus.inUse:
        return 'In Use';
      case ScooterStatus.reserved:
        return 'Reserved';
      case ScooterStatus.maintenance:
        return 'Maintenance';
      case ScooterStatus.lowBattery:
        return 'Low Battery';
      case ScooterStatus.offline:
        return 'Offline';
    }
  }
}
