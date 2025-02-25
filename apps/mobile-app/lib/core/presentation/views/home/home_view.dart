import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
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

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return BikeContainer(
      padding: EdgeInsets.all(16),
      borderRadius: BikeBorderRadiuses.radius32,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BikeBorderRadiuses.radius24,
          color: context.theme.whenByValue(
            light: BikeColors.background.light.element,
            dark: BikeColors.background.dark.element,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 74,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                  ),
                  width: 74,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BikeText(
                            "# 123 456",
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
                                "99%",
                                style: BikeTypography.title.small.copyWith(
                                  color: context.theme.whenByValue(
                                    light: BikeColors.text.light.primary,
                                    dark: BikeColors.text.dark.primary,
                                  ),
                                ),
                              ),
                              Icon(Icons.battery_full, color: Colors.green),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BikeText(
                                "76 км, ",
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
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: BikeButton(
                    title: 'Заблокировать',
                    onPressed: () async {
                      final result = await RestClient().app.lock(12);
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
                      final result = await RestClient().app.unlock(12);
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

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.pink[100],
            child: BikeMapWidget(
              onRegionChanged: (region) {
                print('region is $region');
              },
            ),
          ),
          SafeArea(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: FutureBuilder(
                          future: RestClient().app.fetchDevices(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Ошибка загрузки данных'));
                            }
                            final data = snapshot.data;
                            return SizedBox(
                              height: 170,
                              child: BikeModal(item: data[1]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
