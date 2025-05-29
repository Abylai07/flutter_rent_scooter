part of 'refresh_bloc.dart';

@freezed
class RefreshBlocState with _$RefreshBlocState {
  const factory RefreshBlocState.idle() = _RefreshBlocStateIdle;
  const factory RefreshBlocState.success() = _RefreshBlocStateSuccess;
  const factory RefreshBlocState.error({required String message}) = _RefreshBlocStateError;
}
