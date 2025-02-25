import 'package:almabike_app/core/presentation/utils/navigation/route_config.dart';
import 'package:almabike_app/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<ThemeUtil>().changeTheme();
                    },
                    borderRadius: BikeBorderRadiuses.radius16,
                    child: Container(
                      height: 32,
                      width: 94,
                      decoration: BoxDecoration(
                        color: context.theme.whenByValue(
                          light: BikeColors.background.dark.element,
                          dark: BikeColors.background.light.element,
                        ),
                        borderRadius: BikeBorderRadiuses.radius16,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BikeBorderRadiuses.radius16,
                    onTap: () {
                      final localization = context.read<LocalizationUtil>();

                      final localeEn = localization.supportedLocales[0];
                      final localeRu = localization.supportedLocales[2];

                      final locale = localization.locale;
                      if (locale == localeEn) {
                        localization.setRu();
                      } else if (locale == localeRu) {
                        localization.setKk();
                      } else {
                        localization.setEn();
                      }
                    },
                    child: Container(
                      height: 32,
                      width: 94,
                      decoration: BoxDecoration(
                        color: context.theme.whenByValue(
                          light: BikeColors.background.light.element,
                          dark: BikeColors.background.dark.element,
                        ),
                        borderRadius: BikeBorderRadiuses.radius16,
                      ),
                      child: Center(
                        child: BikeText(
                          Localization.of(context).language,
                          style: BikeTypography.body.medium.copyWith(
                            color: context.theme.whenByValue(
                              light: BikeColors.text.light.primary,
                              dark: BikeColors.text.dark.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              AspectRatio(
                aspectRatio: 328 / 24,
                child: Assets.logos.logo.svg(),
              ),
              SizedBox(height: 40),
              BikeText(
                Localization.of(context).enter_phone_number,
                style: BikeTypography.headline.large.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.text.light.primary,
                    dark: BikeColors.text.dark.primary,
                  ),
                ),
              ),
              SizedBox(height: 24),
              BikePhoneWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BikeButton(
            title: Localization.of(context).get_code,
            onPressed: () {
              isAuthenticated = true;
              AutoRouter.of(context).replace(HomeRoute());
            },
          ),
        ),
      ),
    );
  }
}
