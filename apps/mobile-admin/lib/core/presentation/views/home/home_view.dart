import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device/device_model.dart';
import 'package:almabike_shared/core/utils/networking/https/rest_client.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_icon_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/core/widgets/core/map/map_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BikeModal extends StatelessWidget {
  const BikeModal({super.key, required this.item});

  final Device item;

  @override
  Widget build(BuildContext context) {
    return BikeContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BikeBorderRadiuses.radius32,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BikeBorderRadiuses.radius24,
              color: context.theme.whenByValue(
                light: BikeColors.background.light.element,
                dark: BikeColors.background.dark.element,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BikeText(
                      item.name,
                      style: BikeTypography.title.medium.copyWith(
                        color: context.theme.whenByValue(
                          light: BikeColors.text.light.primary,
                          dark: BikeColors.text.dark.primary,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        BikeText(
                          "${item.position?.attributes['batteryLevel'] ?? 0}%",
                          style: BikeTypography.title.small.copyWith(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.primary,
                              dark: BikeColors.text.dark.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.secondary,
                              dark: BikeColors.text.dark.secondary,
                            ),
                            borderRadius: BikeBorderRadiuses.radius4,
                          ),
                          child: Container(
                            height: 10,
                            width: 22,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: context.theme.whenByValue(
                                  light: BikeColors.background.light.primary,
                                  dark: BikeColors.background.dark.primary,
                                ),
                              ),
                              color: context.theme.whenByValue(
                                light: BikeColors.main.light.primary,
                                dark: BikeColors.main.dark.primary,
                              ),
                              borderRadius: BikeBorderRadiuses.radius2,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BikeText(
                          '${((item.position?.attributes['totalDistance'] as num? ?? 0) / 1000).toInt()} км, ',
                          style: BikeTypography.title.small.copyWith(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.secondary,
                              dark: BikeColors.text.dark.secondary,
                            ),
                          ),
                        ),
                        BikeText(
                          "запас хода",
                          style: BikeTypography.body.small.copyWith(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.secondary,
                              dark: BikeColors.text.dark.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BikeText(
                      "≈ 4 часа",
                      style: BikeTypography.body.small.copyWith(
                        color: context.theme.whenByValue(
                          light: BikeColors.text.light.secondary,
                          dark: BikeColors.text.dark.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BikeButton(
            title: 'Разблокировать батарею',
            onPressed: () async {
              final result = await RestClient().device.unlockBattery(item.id);
              showSnackBar(
                context,
                name: result['deviceId'].toString(),
              );
            },
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, {required String name}) {
    final snackBar = SnackBar(
      content: Text('Батарея $name успешно разблокирована'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class BikeModalActionWidget extends StatelessWidget {
  final String title;
  final String description;
  const BikeModalActionWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BikeContainer(
      height: 92,
      width: size.width / 4,
      borderRadius: BikeBorderRadiuses.radius24,
      withBorder: true,
      withShadow: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BikeText(
            title,
            style: BikeTypography.title.small.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.primary,
                dark: BikeColors.text.dark.primary,
              ),
            ),
          ),
          BikeText(
            description,
            style: BikeTypography.body.small.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.secondary,
                dark: BikeColors.text.dark.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class ToirHomeView extends StatefulWidget {
  const ToirHomeView({super.key});

  @override
  State<ToirHomeView> createState() => _ToirHomeViewState();
}

class _ToirHomeViewState extends State<ToirHomeView> {
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
