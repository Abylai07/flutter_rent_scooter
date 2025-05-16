part of 'auth_bloc.dart';

@freezed
sealed class AuthBlocState with _$AuthBlocState {
  const factory AuthBlocState.idle() = _AuthBlocStateIdle;
  const factory AuthBlocState.success({required String phone}) =
      _AuthBlocStateSuccess;
  const factory AuthBlocState.error() = _AuthBlocStateError;
}
