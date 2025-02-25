import 'package:almabike_shared/core/utils/service/bike_debouncer.dart';
import 'package:almabike_shared/core/widgets/core/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class BikeMapWidget extends StatefulWidget {
  const BikeMapWidget({super.key, this.onRegionChanged});

  final void Function(Region region)? onRegionChanged;

  @override
  State<BikeMapWidget> createState() => _BikeMapWidgetState();
}

class _BikeMapWidgetState extends State<BikeMapWidget> {
  final controller = MapController.withUserPosition(
    trackUserLocation: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
    useExternalTracking: true,
  );

  final debouncer = BikeDebouncer();

  @override
  void dispose() {
    controller.dispose();
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        state.whenOrNull(
          bikes: (markers) async {
            final points = markers
                .map(
                  (e) => GeoPoint(
                    latitude: e['position']['latitude'],
                    longitude: e['position']['longitude'],
                  ),
                )
                .toList();
            await _addMarkers(markers: points);
          },
        );
      },
      builder: (context, state) {
        return OSMFlutter(
          controller: controller
            ..listenerRegionIsChanging.addListener(
              () {
                debouncer.run(() {
                  final region = controller.listenerRegionIsChanging.value;
                  if (region != null) {
                    widget.onRegionChanged?.call(region);
                  }
                });
              },
            ),
          osmOption: OSMOption(
            userTrackingOption: const UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: const ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: const RoadOption(
              roadColor: Colors.yellowAccent,
            ),
          ),
        );
      },
    );
  }

  Future<void> _addMarkers({required List<GeoPoint> markers}) async {
    for (var marker in markers) {
      await controller.addMarker(
        marker,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
  }
}
