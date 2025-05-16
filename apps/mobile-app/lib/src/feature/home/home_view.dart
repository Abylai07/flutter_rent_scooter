import 'package:almabike_app/src/feature/home/widgets/bike_modal.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device_model.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_icon_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/core/widgets/core/map/map_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Device? device;
  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      body: Stack(
        children: [
          BikeMapWidget(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                          size: BikeIconButtonSizeL(),
                        ),
                        BikeContainer(
                          padding: EdgeInsets.all(12),
                          borderRadius: BikeBorderRadiuses.radius16,
                          child: BikeText(
                            '369 Б',
                            style: BikeTypography.body.medium,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BikeIconButton(
                              icon: BikeIcons.user,
                              onPressed: () {},
                              size: BikeIconButtonSizeL(),
                            ),
                            InkWell(
                              onTap: () {},
                              child: BikeContainer(
                                shape: BoxShape.circle,
                                height: 80,
                                width: 80,
                                color: context.theme.whenByValue(
                                  light: BikeColors.background.light.button,
                                  dark: BikeColors.background.dark.button,
                                ),
                                child: Icon(
                                  BikeIcons.scan,
                                  size: 40,
                                  color: context.theme.whenByValue(
                                    light: BikeColors.icon.light.white,
                                    dark: BikeColors.icon.dark.white,
                                  ),
                                ),
                              ),
                            ),
                            BikeIconButton(
                              icon: BikeIcons.lock,
                              onPressed: () {},
                              size: BikeIconButtonSizeL(),
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
                  ],
                ),
              ),
            ),
            onMapTapped: () {
              setState(() {
                device = null;
              });
            },
            onDeviceTapped: (tappedDevice) {
              setState(() {
                device = tappedDevice;
              });
            },
          ),
        ],
      ),
    );
  }
}
