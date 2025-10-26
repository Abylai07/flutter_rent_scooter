import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';

part 'scooter_map_event.dart';
part 'scooter_map_state.dart';

class ScooterMapBloc extends Bloc<ScooterMapEvent, ScooterMapState> {
  Timer? _scooterRefreshTimer;
  Position? _userLocation;
  final Set<int> _favoriteScooters = {};

  ScooterMapBloc() : super(ScooterMapInitial()) {
    on<LoadScootersRequested>(_onLoadScooters);
    on<FilterScootersRequested>(_onFilterScooters);
    on<SearchScootersRequested>(_onSearchScooters);
    on<UpdateUserLocationRequested>(_onUpdateUserLocation);
    on<SelectScooterRequested>(_onSelectScooter);
    on<ReserveScooterRequested>(_onReserveScooter);
    on<CancelReservationRequested>(_onCancelReservation);
    on<ToggleFavoriteScooterRequested>(_onToggleFavorite);
    on<StartAutoRefreshRequested>(_onStartAutoRefresh);
    on<StopAutoRefreshRequested>(_onStopAutoRefresh);
  }

  Future<void> _onLoadScooters(
    LoadScootersRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    emit(ScooterMapLoading());

    try {
      final position = await _getCurrentPosition();
      _userLocation = position;

      final scooters = await _fetchNearbyScooters(
        position.latitude,
        position.longitude,
        event.radiusKm,
      );

      final sortedScooters = _sortScootersByDistance(scooters, position);

      emit(ScooterMapLoaded(
        scooters: sortedScooters,
        userLocation: position,
        filteredScooters: sortedScooters,
      ));
    } catch (e) {
      emit(ScooterMapError(message: e.toString()));
    }
  }

  Future<void> _onFilterScooters(
    FilterScootersRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    final currentState = state as ScooterMapLoaded;

    final filtered = currentState.scooters.where((scooter) {
      if (event.minBattery != null && scooter.batteryLevel < event.minBattery!) {
        return false;
      }

      if (event.maxDistance != null && _userLocation != null) {
        final distance = Geolocator.distanceBetween(
          _userLocation!.latitude,
          _userLocation!.longitude,
          scooter.latitude,
          scooter.longitude,
        ) / 1000;

        if (distance > event.maxDistance!) {
          return false;
        }
      }

      if (event.onlyAvailable && !scooter.status.isAvailable) {
        return false;
      }

      if (event.maxPrice != null && scooter.pricePerMinute > event.maxPrice!) {
        return false;
      }

      return true;
    }).toList();

    emit(currentState.copyWith(
      filteredScooters: filtered,
      activeFilter: event,
    ));
  }

  Future<void> _onSearchScooters(
    SearchScootersRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    final currentState = state as ScooterMapLoaded;

    if (event.query.isEmpty) {
      emit(currentState.copyWith(
        filteredScooters: currentState.scooters,
        searchQuery: null,
      ));
      return;
    }

    final searchResults = currentState.scooters.where((scooter) {
      return scooter.deviceId.toLowerCase().contains(event.query.toLowerCase()) ||
          scooter.qrCode.toLowerCase().contains(event.query.toLowerCase()) ||
          scooter.id.toString().contains(event.query);
    }).toList();

    emit(currentState.copyWith(
      filteredScooters: searchResults,
      searchQuery: event.query,
    ));
  }

  Future<void> _onUpdateUserLocation(
    UpdateUserLocationRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    try {
      final position = await _getCurrentPosition();
      _userLocation = position;

      final currentState = state as ScooterMapLoaded;
      final sortedScooters = _sortScootersByDistance(
        currentState.scooters,
        position,
      );

      emit(currentState.copyWith(
        scooters: sortedScooters,
        userLocation: position,
        filteredScooters: _sortScootersByDistance(
          currentState.filteredScooters,
          position,
        ),
      ));
    } catch (e) {
      // Continue with old location
    }
  }

  Future<void> _onSelectScooter(
    SelectScooterRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    final currentState = state as ScooterMapLoaded;

    emit(currentState.copyWith(selectedScooter: event.scooter));
  }

  Future<void> _onReserveScooter(
    ReserveScooterRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    final currentState = state as ScooterMapLoaded;

    emit(ScooterMapLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final updatedScooters = currentState.scooters.map((s) {
        if (s.id == event.scooterId) {
          return s.copyWith(status: ScooterStatus.reserved);
        }
        return s;
      }).toList();

      emit(currentState.copyWith(
        scooters: updatedScooters,
        filteredScooters: updatedScooters
            .where((s) => currentState.filteredScooters.contains(s))
            .toList(),
        reservedScooterId: event.scooterId,
      ));
    } catch (e) {
      emit(ScooterMapError(
        message: 'Failed to reserve scooter',
        previousState: currentState,
      ));
    }
  }

  Future<void> _onCancelReservation(
    CancelReservationRequested event,
    Emitter<ScooterMapState> emit,
  ) async {
    if (state is! ScooterMapLoaded) return;

    final currentState = state as ScooterMapLoaded;

    final updatedScooters = currentState.scooters.map((s) {
      if (s.id == currentState.reservedScooterId) {
        return s.copyWith(status: ScooterStatus.available);
      }
      return s;
    }).toList();

    emit(currentState.copyWith(
      scooters: updatedScooters,
      filteredScooters: updatedScooters
          .where((s) => currentState.filteredScooters.any((f) => f.id == s.id))
          .toList(),
      reservedScooterId: null,
      selectedScooter: null,
    ));
  }

  void _onToggleFavorite(
    ToggleFavoriteScooterRequested event,
    Emitter<ScooterMapState> emit,
  ) {
    if (_favoriteScooters.contains(event.scooterId)) {
      _favoriteScooters.remove(event.scooterId);
    } else {
      _favoriteScooters.add(event.scooterId);
    }

    if (state is ScooterMapLoaded) {
      emit((state as ScooterMapLoaded).copyWith(
        favoriteScooterIds: Set.from(_favoriteScooters),
      ));
    }
  }

  void _onStartAutoRefresh(
    StartAutoRefreshRequested event,
    Emitter<ScooterMapState> emit,
  ) {
    _scooterRefreshTimer?.cancel();
    _scooterRefreshTimer = Timer.periodic(
      Duration(seconds: event.intervalSeconds),
      (_) => add(LoadScootersRequested()),
    );
  }

  void _onStopAutoRefresh(
    StopAutoRefreshRequested event,
    Emitter<ScooterMapState> emit,
  ) {
    _scooterRefreshTimer?.cancel();
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<ScooterModel>> _fetchNearbyScooters(
    double lat,
    double lng,
    double radiusKm,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(15, (index) {
      final offsetLat = (index % 5 - 2) * 0.01;
      final offsetLng = (index ~/ 5 - 2) * 0.01;

      return ScooterModel(
        id: index + 1,
        deviceId: 'SC${(1000 + index).toString()}',
        qrCode: 'QR${(10000 + index).toString()}',
        latitude: lat + offsetLat,
        longitude: lng + offsetLng,
        batteryLevel: 20 + (index * 5) % 80,
        status: index % 4 == 0 ? ScooterStatus.inUse : ScooterStatus.available,
        pricePerMinute: 0.5 + (index % 3) * 0.1,
        totalRidesCount: 100 + index * 10,
        averageRating: 4.0 + (index % 10) * 0.1,
      );
    });
  }

  List<ScooterModel> _sortScootersByDistance(
    List<ScooterModel> scooters,
    Position userLocation,
  ) {
    final scootersWithDistance = scooters.map((scooter) {
      final distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        scooter.latitude,
        scooter.longitude,
      );
      return MapEntry(scooter, distance);
    }).toList();

    scootersWithDistance.sort((a, b) => a.value.compareTo(b.value));

    return scootersWithDistance.map((e) => e.key).toList();
  }

  @override
  Future<void> close() {
    _scooterRefreshTimer?.cancel();
    return super.close();
  }
}
