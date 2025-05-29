import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class Device with _$Device {
  const factory Device({
    required int id,
    required Map<String, dynamic> attributes,
    required int groupId,
    required int calendarId,
    required String name,
    required String uniqueId,
    required String status,
    String? lastUpdate,
    required int positionId,
    String? phone,
    String? model,
    String? contact,
    String? category,
    required bool disabled,
    String? expirationTime,
    Position? position,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}

@freezed
class Position with _$Position {
  const factory Position({
    required int id,
    required Map<String, dynamic> attributes,
    required int deviceId,
    required String protocol,
    required String serverTime,
    required String deviceTime,
    required String fixTime,
    required bool outdated,
    required bool valid,
    required double latitude,
    required double longitude,
    required double altitude,
    required double speed,
    required double course,
    String? address,
    required double accuracy,
    String? network,
    List<int>? geofenceIds,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}
