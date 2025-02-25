part of 'map_bloc.dart';

@freezed
sealed class MapState with _$MapState {
  const factory MapState.init() = _MapStateLoading;

  const factory MapState.bikes({
    required List<Map<String, dynamic>> bikes,
  }) = _MapStateBikes;
}
