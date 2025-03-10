part of 'auth_verification_bloc.dart';

@freezed
sealed class AuthVerificationBlocState with _$AuthVerificationBlocState {
  const factory AuthVerificationBlocState.idle() =
      _AuthVerificationBlocStateIdle;
  const factory AuthVerificationBlocState.success() =
      _AuthVerificationBlocStateSuccess;
  const factory AuthVerificationBlocState.error({required String message}) =
      _AuthVerificationBlocStateError;
}
