import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device_model.dart';
import 'package:almabike_shared/core/utils/networking/https/rest_client.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';

import 'bike_modal_action.dart';

class BikeModal extends StatelessWidget {
  const BikeModal({super.key, required this.item});

  final Device item;

  @override
  Widget build(BuildContext context) {
    return BikeContainer(
      padding: EdgeInsets.all(16),
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
                        SizedBox(width: 8),
                        BikeText(
                          "${item.position?.attributes['batteryLevel'] ?? 0}%",
                          style: BikeTypography.title.small.copyWith(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.primary,
                              dark: BikeColors.text.dark.primary,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
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
                            margin: EdgeInsets.all(1),
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
                SizedBox(height: 8),
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BikeModalActionWidget(
                title: '10:20',
                description: 'В пути',
              ),
              BikeModalActionWidget(
                title: '550 ₸',
                description: 'Цена',
              ),
              BikeModalActionWidget(
                title: '1 км',
                description: 'Растояние',
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: BikeButton(
                  title: 'Заблокировать',
                  onPressed: () async {
                    final result = await RestClient().app.lock(item.id);
                    showSnackBar(
                      context,
                      name: result['deviceId'].toString(),
                      isLock: true,
                    );
                  },
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: BikeButton(
                  title: 'Разблокировать',
                  onPressed: () async {
                    final result = await RestClient().app.unlock(item.id);
                    showSnackBar(
                      context,
                      name: result['deviceId'].toString(),
                      isLock: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context,
      {required String name, required bool isLock}) {
    final snackBar = SnackBar(
      content: Text('Bike: $name is ${isLock ? 'locked' : 'unlocked'}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
