import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_bloc.freezed.dart';
part 'refresh_event.dart';
part 'refresh_state.dart';

class RefreshBloc
    extends Bloc<RefreshBlocEvent, RefreshBlocState> {
  RefreshBloc({required this.restClient})
      : super(const RefreshBlocState.idle()) {
    on<RefreshBlocEvent>((event, emit) async {
      await event.when(
        refresh: () async {
          try {
            final refresh = AppStorage.refreshToken;
            if(refresh != null){
              final result = await restClient.refresh(refresh, 'mobile_client');
              isAuthenticated = true;
              AppStorage.accessToken = result.accessToken;
              AppStorage.refreshToken = result.refreshToken;

              emit(const RefreshBlocState.success());
            } else {
              emit(const RefreshBlocState.error(message: 'No Refresh Token'));
            }
          } catch (e) {
            emit(RefreshBlocState.error(message: e.toString()));
          }
        },
      );
    });
  }

  final AuthRestClient restClient;
}
