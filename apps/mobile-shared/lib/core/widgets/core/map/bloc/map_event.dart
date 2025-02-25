part of 'map_bloc.dart';

@freezed
sealed class MapBlocEvent with _$MapBlocEvent {
  const factory MapBlocEvent.get() = _MapBlocEventGet;
}
