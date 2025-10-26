part of 'scooter_map_bloc.dart';

sealed class ScooterMapState extends Equatable {
  const ScooterMapState();

  @override
  List<Object?> get props => [];
}

class ScooterMapInitial extends ScooterMapState {}

class ScooterMapLoading extends ScooterMapState {
  final ScooterMapLoaded? previousState;

  const ScooterMapLoading({this.previousState});

  @override
  List<Object?> get props => [previousState];
}

class ScooterMapLoaded extends ScooterMapState {
  final List<ScooterModel> scooters;
  final List<ScooterModel> filteredScooters;
  final Position userLocation;
  final ScooterModel? selectedScooter;
  final int? reservedScooterId;
  final FilterScootersRequested? activeFilter;
  final String? searchQuery;
  final Set<int> favoriteScooterIds;

  const ScooterMapLoaded({
    required this.scooters,
    required this.filteredScooters,
    required this.userLocation,
    this.selectedScooter,
    this.reservedScooterId,
    this.activeFilter,
    this.searchQuery,
    this.favoriteScooterIds = const {},
  });

  ScooterMapLoaded copyWith({
    List<ScooterModel>? scooters,
    List<ScooterModel>? filteredScooters,
    Position? userLocation,
    ScooterModel? selectedScooter,
    int? reservedScooterId,
    FilterScootersRequested? activeFilter,
    String? searchQuery,
    Set<int>? favoriteScooterIds,
  }) {
    return ScooterMapLoaded(
      scooters: scooters ?? this.scooters,
      filteredScooters: filteredScooters ?? this.filteredScooters,
      userLocation: userLocation ?? this.userLocation,
      selectedScooter: selectedScooter,
      reservedScooterId: reservedScooterId,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery,
      favoriteScooterIds: favoriteScooterIds ?? this.favoriteScooterIds,
    );
  }

  @override
  List<Object?> get props => [
        scooters,
        filteredScooters,
        userLocation,
        selectedScooter,
        reservedScooterId,
        activeFilter,
        searchQuery,
        favoriteScooterIds,
      ];
}

class ScooterMapError extends ScooterMapState {
  final String message;
  final ScooterMapLoaded? previousState;

  const ScooterMapError({
    required this.message,
    this.previousState,
  });

  @override
  List<Object?> get props => [message, previousState];
}
