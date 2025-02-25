part of 'map_bloc.dart';

@freezed
sealed class MapBlocState with _$MapBlocState {
  const factory MapBlocState.init() = _MapBlocStateLoading;

  const factory MapBlocState.bikes({
    required List<Device> bikes,
  }) = _MapBlocStateBikes;
}
