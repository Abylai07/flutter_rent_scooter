import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/networking/https/models/device/device_model.dart';

part 'map_bloc.freezed.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  MapBloc({required this.restClient}) : super(const MapBlocState.init()) {
    on<MapBlocEvent>((event, emit) async {
      await event.when(
        get: () async {
          try {
            final bikes = await restClient.fetchDevices();

            emit(MapBlocState.bikes(bikes: bikes));
          } catch (e) {
            emit(const MapBlocState.init());
          }
        },
      );
    });
  }

  final DeviceRestClient restClient;
}
