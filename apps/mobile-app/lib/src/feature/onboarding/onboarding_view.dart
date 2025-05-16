import 'package:almabike_app/src/core/utils/navigation/route_config.gr.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class OnboardingEntity {
  final String title;
  final List<OnboardingBodyEntity> body;
  final Image image;
  final String buttonText;
  final VoidCallback onPressed;

  const OnboardingEntity({
    required this.title,
    required this.body,
    required this.image,
    required this.onPressed,
    required this.buttonText,
  });
}

class OnboardingBodyEntity {
  final String title;
  final Widget child;
  final bool isInfo;

  OnboardingBodyEntity({
    required this.title,
    required this.child,
    this.isInfo = true,
  });
}

class _OnboardingViewState extends State<OnboardingView> {
  int index = 0;
  List<OnboardingEntity> entities(BuildContext context) => [
        OnboardingEntity(
          body: [
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_0_description_0,
              child: Icon(BikeIcons.bike),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_0_description_1,
              child: Icon(BikeIcons.phone),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_0_description_2,
              child: Icon(BikeIcons.shield),
            ),
          ],
          title: Localization.of(context).onboadring_0_title,
          image: Assets.images.media.onboarding0.image(fit: BoxFit.fill),
          onPressed: () {
            setState(() {
              index++;
            });
          },
          buttonText: Localization.of(context).next,
        ),
        OnboardingEntity(
          body: [
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_1_description_0,
              child: BikeText(
                '1',
                style: BikeTypography.body.medium.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.icon.light.white,
                    dark: BikeColors.icon.dark.white,
                  ),
                ),
              ),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_1_description_1,
              child: BikeText(
                '2',
                style: BikeTypography.body.medium.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.icon.light.white,
                    dark: BikeColors.icon.dark.white,
                  ),
                ),
              ),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_1_description_2,
              child: BikeText(
                '3',
                style: BikeTypography.body.medium.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.icon.light.white,
                    dark: BikeColors.icon.dark.white,
                  ),
                ),
              ),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_1_description_3,
              child: BikeText(
                '4',
                style: BikeTypography.body.medium.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.icon.light.white,
                    dark: BikeColors.icon.dark.white,
                  ),
                ),
              ),
            ),
          ],
          title: Localization.of(context).onboadring_1_title,
          image: Assets.images.media.onboarding1.image(fit: BoxFit.fill),
          onPressed: () {
            setState(() {
              index++;
            });
          },
          buttonText: Localization.of(context).next,
        ),
        OnboardingEntity(
          body: [
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_2_description_0,
              child: Icon(BikeIcons.check),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_2_description_1,
              child: Icon(BikeIcons.check),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_2_description_2,
              child: Icon(BikeIcons.close),
              isInfo: false,
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_2_description_3,
              child: Icon(BikeIcons.close),
              isInfo: false,
            ),
          ],
          title: Localization.of(context).onboadring_2_title,
          image: Assets.images.media.onboarding2.image(fit: BoxFit.fill),
          onPressed: () {
            setState(() {
              index++;
            });
          },
          buttonText: Localization.of(context).next,
        ),
        OnboardingEntity(
          body: [
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_3_description_0,
              child: Icon(BikeIcons.check),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_3_description_1,
              child: Icon(BikeIcons.check),
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_3_description_2,
              child: Icon(BikeIcons.close),
              isInfo: false,
            ),
            OnboardingBodyEntity(
              title: Localization.of(context).onboadring_3_description_3,
              child: Icon(BikeIcons.close),
              isInfo: false,
            ),
          ],
          title: Localization.of(context).onboadring_3_title,
          image: Assets.images.media.onboarding3.image(fit: BoxFit.fill),
          onPressed: () => AutoRouter.of(context).replace(AuthRoute()),
          buttonText: Localization.of(context).start_ride,
        ),
      ];
  OnboardingEntity get entity => entities(context)[index];

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      bgColor: context.theme.whenByValue(
        light: BikeColors.background.light.secondary,
        dark: BikeColors.background.dark.secondary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: AspectRatio(
                  aspectRatio: 328 / 240,
                  child: entity.image,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 4,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BikeBorderRadiuses.radius12,
                          color: isPageSelected(i: index)
                              ? context.theme.whenByValue(
                                  light: BikeColors.main.light.primary,
                                  dark: BikeColors.main.dark.primary,
                                )
                              : context.theme.whenByValue(
                                  light: BikeColors.icon.light.grey,
                                  dark: BikeColors.icon.dark.grey,
                                ),
                        ),
                        width: isPageSelected(i: index) ? 20 : 4,
                        height: 4,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 4,
                    ),
                    itemCount: entities(context).length,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: BikeText(
                  entity.title,
                  maxLines: 2,
                  style: BikeTypography.headline.medium.copyWith(
                    color: context.theme.whenByValue(
                      light: BikeColors.text.light.primary,
                      dark: BikeColors.text.dark.primary,
                    ),
                  ),
                ),
              ),
              for (final body in entity.body)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BikeBorderRadiuses.radius12,
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.primary,
                        dark: BikeColors.background.dark.primary,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: body.isInfo
                                ? context.theme.whenByValue(
                                    light: BikeColors.main.light.primary,
                                    dark: BikeColors.main.dark.primary,
                                  )
                                : context.theme.whenByValue(
                                    light: BikeColors.main.light.red,
                                    dark: BikeColors.main.dark.red,
                                  ),
                          ),
                          child: Theme(
                            data: ThemeData(
                              iconTheme: IconThemeData(
                                size: 16,
                                color: context.theme.whenByValue(
                                  light: BikeColors.icon.light.white,
                                  dark: BikeColors.icon.dark.white,
                                ),
                              ),
                            ),
                            child: Center(
                              child: body.child,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: BikeText(
                            body.title,
                            style: BikeTypography.body.medium.copyWith(
                              color: context.theme.whenByValue(
                                light: BikeColors.text.light.primary,
                                dark: BikeColors.text.dark.primary,
                              ),
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: context.theme.whenByValue(
          light: BikeColors.background.light.primary,
          dark: BikeColors.background.dark.primary,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BikeButton(
              title: entity.buttonText,
              onPressed: entity.onPressed,
            ),
          ),
        ),
      ),
    );
  }

  bool isPageSelected({required int i}) => i == index;
}
