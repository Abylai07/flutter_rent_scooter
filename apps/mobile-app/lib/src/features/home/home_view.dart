import 'dart:developer';

import 'package:almabike_app/src/core/utils/mixins/location_mixin.dart';
import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_app/src/features/home/widgets/bike_modal.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device/device_model.dart';
import 'package:almabike_shared/core/utils/networking/https/rest_client.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_icon_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/core/widgets/core/map/bloc/map_bloc.dart';
import 'package:almabike_shared/core/widgets/core/map/map_common.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dgis_mobile_sdk_map/dgis.dart' as sdk;

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with LocationMixin {
  Device? device;

  final mapWidgetController = sdk.MapWidgetController();
  final sdkContext = AppContainer().initializeSdk();

  @override
  void initState() {
    // mapWidgetController.getMapAsync((map) {
    //   map.camera.position = const sdk.CameraPosition(
    //     point: sdk.GeoPoint(
    //       latitude: sdk.Latitude(43.238949),
    //       longitude: sdk.Longitude(76.889709),
    //     ),
    //     zoom: sdk.Zoom(14),
    //   );
    // });
    final locationService = sdk.LocationService(sdkContext);
    checkLocationPermissions(locationService).then((_) {
      mapWidgetController.getMapAsync((map) {
        final locationSource = sdk.MyLocationMapObjectSource(sdkContext);
        map.addSource(locationSource);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(restClient: RestClient().device)
        ..add(
          const MapBlocEvent.get(),
        ),
      child: BikeScaffold(
        body: BlocConsumer<MapBloc, MapBlocState>(
          listener: (context, state) {
            // switch(state.runtimeType){
            //   case MapBlocStateBikes bike:
            //     return addMarkers(bike.bikes);
            // }
            state.whenOrNull(
              bikes: (markers) {
                // addMarkers(markers);
              },
            );
          },
          builder: (context, state) {
            return sdk.MapWidget(
              key: ValueKey(context.isLight),
              sdkContext: sdkContext,
              mapOptions: sdk.MapOptions(
                position: const sdk.CameraPosition(
                  point: sdk.GeoPoint(
                    latitude: sdk.Latitude(43.238949),
                    longitude: sdk.Longitude(76.889709),
                  ),
                  zoom: sdk.Zoom(13),
                ),
                appearance: sdk.UniversalAppearance(
                  context.isLight
                      ? const sdk.MapTheme.defaultDayTheme()
                      : const sdk.MapTheme.defaultNightTheme(),
                ),
              ),
              controller: mapWidgetController,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                sdk.ZoomWidget(),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: sdk.CompassWidget(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: sdk.MyLocationWidget(),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BikeIconButton(
                                icon: BikeIcons.question_small,
                                onPressed: () {
                                  context.read<ThemeUtil>().changeTheme();
                                },
                                size: const BikeIconButtonSizeL(),
                              ),
                              Column(
                                children: [
                                  BikeContainer(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    borderRadius: BikeBorderRadiuses.radius20,
                                    child: Row(
                                      children: [
                                        BikeText(
                                          '369 Б',
                                          style: BikeTypography.body.medium
                                              .copyWith(
                                                  color: BikeColors
                                                      .text.dark.green),
                                        ),
                                        const SizedBox(width: 6),
                                        BikeContainer(
                                          shape: BoxShape.circle,
                                          height: 16,
                                          width: 16,
                                          withShadow: false,
                                          color: context.theme.whenByValue(
                                              light: BikeColors
                                                  .background.light.grey,
                                              dark: BikeColors
                                                  .background.dark.grey),
                                          child: Assets.icons.addLittle.svg(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BikeIconButton(
                                        icon: BikeIcons.user,
                                        onPressed: () => context
                                            .pushRoute(const ProfileRoute()),
                                        size: const BikeIconButtonSizeL(),
                                      ),
                                      InkWell(
                                        onTap: () => context.router
                                            .push(const QrScannerRoute()),
                                        child: BikeContainer(
                                          shape: BoxShape.circle,
                                          height: 80,
                                          width: 80,
                                          color: BikeColors
                                              .background.light.button,
                                          child: Assets.icons.scan.svg(
                                            colorFilter: context.svgColor(
                                              light:
                                                  BikeColors.icon.light.white,
                                              dark: BikeColors.icon.dark.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      BikeIconButton(
                                        icon: BikeIcons.active_geo,
                                        onPressed: () {
                                          final locationService =
                                              sdk.LocationService(sdkContext);
                                          checkLocationPermissions(
                                                  locationService)
                                              .then((_) {
                                            mapWidgetController
                                                .getMapAsync((map) {
                                              final locationSource =
                                                  sdk.MyLocationMapObjectSource(
                                                      sdkContext);
                                              map.addSource(locationSource);
                                            });
                                          });
                                        },
                                        size: const BikeIconButtonSizeL(),
                                      ),
                                    ],
                                  ),
                                  if (device != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: BikeModal(item: device!),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
