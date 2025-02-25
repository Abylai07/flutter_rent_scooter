import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_bloc.freezed.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required this.restClient}) : super(const MapState.init()) {
    on<MapEvent>((event, emit) async {
      await event.when(
        get: () async {
          try {
            final bikes = await restClient.fetchDevices();
            emit(MapState.bikes(bikes: bikes));
          } catch (e) {
            emit(const MapState.init());
          }
        },
      );
    });
  }

  final IRestClient restClient;
}
