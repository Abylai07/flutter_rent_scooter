import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_verification_bloc.freezed.dart';
part 'auth_verification_event.dart';
part 'auth_verification_state.dart';

class AuthVerificationBloc
    extends Bloc<AuthVerificationBlocEvent, AuthVerificationBlocState> {
  AuthVerificationBloc({required this.restClient})
      : super(const AuthVerificationBlocState.idle()) {
    on<AuthVerificationBlocEvent>((event, emit) async {
      await event.when(
        verify: (phone, code) async {
          try {
            final result = await restClient.login('+7$phone', code);
            isAuthenticated = true;
            AppStorage.accessToken = result.accessToken;
            AppStorage.refreshToken = result.refreshToken;

            emit(const AuthVerificationBlocState.success());
          } catch (e) {
            emit(AuthVerificationBlocState.error(message: e.toString()));
          }
        },
        resendCode: () {},
      );
    });
  }

  final AuthRestClient restClient;
}
