part of 'auth_verification_bloc.dart';

@freezed
sealed class AuthVerificationBlocEvent with _$AuthVerificationBlocEvent {
  const factory AuthVerificationBlocEvent.verify({
    required String phone,
    required String code,
  }) = _AuthVerificationBlocEventVerify;
  const factory AuthVerificationBlocEvent.resendCode() =
      _AuthVerificationBlocEventReSendCode;
}
