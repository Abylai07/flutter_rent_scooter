import 'package:almabike_shared/core/utils/networking/https/models/device_model.dart';
import 'package:almabike_shared/core/utils/service/bike_debouncer.dart';
import 'package:almabike_shared/core/widgets/core/map/bloc/map_bloc.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BikeMapWidget extends StatefulWidget {
  const BikeMapWidget({
    super.key,
    this.onDeviceTapped,
    this.onMapTapped,
    required this.child,
  });

  final Widget child;
  final void Function(Device device)? onDeviceTapped;
  final VoidCallback? onMapTapped;

  @override
  State<BikeMapWidget> createState() => _BikeMapWidgetState();
}

class _BikeMapWidgetState extends State<BikeMapWidget> {
  List<Marker> markers = [];

  final debouncer = BikeDebouncer();
  final controller = MapController();
  void addMarkers(List<Device> devices) {
    markers.clear();
    markers = devices.map((e) {
      return Marker(
        point: LatLng(e.position?.latitude ?? 0, e.position?.longitude ?? 0),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () {
            widget.onDeviceTapped?.call(e);
          },
          child: Assets.images.markers.bikeMarker.image(
            width: 80,
            height: 80,
          ),
        ),
      );
    }).toList();
    setState(() {});
  }

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.read<MapBloc>()..add(const MapBlocEvent.get()),
      child: BlocConsumer<MapBloc, MapBlocState>(
        listener: (context, state) {
          state.whenOrNull(
            bikes: (markers) {
              addMarkers(markers);
            },
          );
        },
        builder: (context, state) {
          return FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: const LatLng(43.2389498, 76.889709),
              initialZoom: 12,
              onTap: (tapPosition, point) {
                widget.onMapTapped?.call();
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: markers,
              ),
              widget.child,
            ],
          );
        },
      ),
    );
  }
}
