import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc({required this.restClient}) : super(const AuthBlocState.idle()) {
    on<AuthBlocEvent>((event, emit) async {
      await event.when(
        auth: (phone) async {
          try {
            final validPhoneLength = 10;
            final isValidPhone = phone.length == validPhoneLength;
            await restClient.requestPin('+7$phone');
            if (isValidPhone) {
              emit(AuthBlocState.success(phone: phone));
            } else {
              emit(const AuthBlocState.error());
            }
          } catch (e) {
            emit(const AuthBlocState.error());
          }
        },
      );
    });
  }

  final AuthRestClient restClient;
}
