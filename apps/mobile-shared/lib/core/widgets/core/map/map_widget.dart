import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device_model.dart';
import 'package:almabike_shared/core/utils/service/bike_debouncer.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/core/widgets/core/map/bloc/map_bloc.dart';
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
        width: 48,
        height: 48,
        child: GestureDetector(
          onTap: () {
            widget.onDeviceTapped?.call(e);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.primary,
                dark: BikeColors.text.dark.primary,
              ),
              borderRadius: BikeBorderRadiuses.radius8,
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    BikeIcons.bike,
                    size: 16,
                    color: context.theme.whenByValue(
                      light: BikeColors.background.light.primary,
                      dark: BikeColors.background.dark.primary,
                    ),
                  ),
                  FittedBox(
                    child: BikeText(
                      '100%',
                      style: BikeTypography.headline.small.copyWith(
                        color: context.theme.whenByValue(
                          light: BikeColors.main.light.primary,
                          dark: BikeColors.main.dark.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      create: (context) => context.read<MapBloc>()
        ..add(
          const MapBlocEvent.get(),
        ),
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
