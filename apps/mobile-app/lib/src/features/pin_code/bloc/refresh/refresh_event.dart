part of 'refresh_bloc.dart';

@freezed
class RefreshBlocEvent with _$RefreshBlocEvent {
  const factory RefreshBlocEvent.refresh() = _RefreshBlocEventRefresh;
}
