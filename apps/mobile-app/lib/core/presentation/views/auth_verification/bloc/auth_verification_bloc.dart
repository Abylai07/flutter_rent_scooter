import 'package:almabike_app/core/presentation/utils/navigation/route_config.dart';
import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
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
            await restClient.login('+7$phone', code);
            isAuthenticated = true;
            emit(const AuthVerificationBlocState.success());
          } catch (e) {
            emit(AuthVerificationBlocState.error(message: e.toString()));
          }
        },
        resendCode: () {},
      );
    });
  }

  final IRestClient restClient;
}
