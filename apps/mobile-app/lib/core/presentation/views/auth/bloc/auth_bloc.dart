import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
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
          final validPhoneLenght = 10;
          final isValidPhone = phone.length == validPhoneLenght;
          if (isValidPhone) {
            emit(AuthBlocState.success(phone: phone));
          } else {
            emit(const AuthBlocState.error());
          }
        },
      );
    });
  }

  final IRestClient restClient;
}
