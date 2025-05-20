part of 'auth_bloc.dart';

@freezed
sealed class AuthBlocEvent with _$AuthBlocEvent {
  const factory AuthBlocEvent.auth({required String phone}) =
      _AuthBlocEventAuth;
}
