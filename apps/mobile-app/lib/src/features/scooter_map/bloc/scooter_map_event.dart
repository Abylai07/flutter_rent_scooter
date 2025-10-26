part of 'scooter_map_bloc.dart';

sealed class ScooterMapEvent extends Equatable {
  const ScooterMapEvent();

  @override
  List<Object?> get props => [];
}

class LoadScootersRequested extends ScooterMapEvent {
  final double radiusKm;

  const LoadScootersRequested({this.radiusKm = 5.0});

  @override
  List<Object?> get props => [radiusKm];
}

class FilterScootersRequested extends ScooterMapEvent {
  final int? minBattery;
  final double? maxDistance;
  final bool onlyAvailable;
  final double? maxPrice;

  const FilterScootersRequested({
    this.minBattery,
    this.maxDistance,
    this.onlyAvailable = false,
    this.maxPrice,
  });

  @override
  List<Object?> get props => [minBattery, maxDistance, onlyAvailable, maxPrice];
}

class SearchScootersRequested extends ScooterMapEvent {
  final String query;

  const SearchScootersRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

class UpdateUserLocationRequested extends ScooterMapEvent {
  const UpdateUserLocationRequested();
}

class SelectScooterRequested extends ScooterMapEvent {
  final ScooterModel scooter;

  const SelectScooterRequested({required this.scooter});

  @override
  List<Object?> get props => [scooter];
}

class ReserveScooterRequested extends ScooterMapEvent {
  final int scooterId;

  const ReserveScooterRequested({required this.scooterId});

  @override
  List<Object?> get props => [scooterId];
}

class CancelReservationRequested extends ScooterMapEvent {
  const CancelReservationRequested();
}

class ToggleFavoriteScooterRequested extends ScooterMapEvent {
  final int scooterId;

  const ToggleFavoriteScooterRequested({required this.scooterId});

  @override
  List<Object?> get props => [scooterId];
}

class StartAutoRefreshRequested extends ScooterMapEvent {
  final int intervalSeconds;

  const StartAutoRefreshRequested({this.intervalSeconds = 30});

  @override
  List<Object?> get props => [intervalSeconds];
}

class StopAutoRefreshRequested extends ScooterMapEvent {
  const StopAutoRefreshRequested();
}
