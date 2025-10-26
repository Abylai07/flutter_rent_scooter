import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_session_model.freezed.dart';
part 'ride_session_model.g.dart';

@freezed
class RideSessionModel with _$RideSessionModel {
  const factory RideSessionModel({
    required int id,
    required int scooterId,
    required int userId,
    required String startTime,
    String? endTime,
    required double startLatitude,
    required double startLongitude,
    double? endLatitude,
    double? endLongitude,
    required RideStatus status,
    @Default(0) int durationMinutes,
    @Default(0.0) double distanceKm,
    @Default(0.0) double totalCost,
    @Default(0.0) double averageSpeed,
    @Default(0) int pauseDurationMinutes,
    List<RideLocationPoint>? routePoints,
  }) = _RideSessionModel;

  factory RideSessionModel.fromJson(Map<String, dynamic> json) =>
      _$RideSessionModelFromJson(json);
}

@freezed
class RideLocationPoint with _$RideLocationPoint {
  const factory RideLocationPoint({
    required double latitude,
    required double longitude,
    required String timestamp,
    required double speed,
    int? batteryLevel,
  }) = _RideLocationPoint;

  factory RideLocationPoint.fromJson(Map<String, dynamic> json) =>
      _$RideLocationPointFromJson(json);
}

enum RideStatus {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('payment_pending')
  paymentPending,
}

extension RideStatusX on RideStatus {
  bool get isActive => this == RideStatus.active;
  bool get isPaused => this == RideStatus.paused;
  bool get isOngoing => this == RideStatus.active || this == RideStatus.paused;
  bool get isFinished => this == RideStatus.completed || this == RideStatus.cancelled;

  String get displayName {
    switch (this) {
      case RideStatus.active:
        return 'Active';
      case RideStatus.paused:
        return 'Paused';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';
      case RideStatus.paymentPending:
        return 'Payment Pending';
    }
  }
}
