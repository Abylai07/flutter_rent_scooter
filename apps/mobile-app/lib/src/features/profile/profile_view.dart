import 'package:almabike_app/src/core/utils/navigation/route_config.dart';
import 'package:almabike_app/src/features/profile/widgets/bike_gray_button.dart';
import 'package:almabike_app/src/features/profile/widgets/show_attention_alert.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProfileEntity> profileElements = [
      ProfileEntity(
        title: Localization.of(context).history,
        icon: Assets.icons.profile.history,
        onTap: () => context.pushRoute(const HistoryRoute()),
      ),
      ProfileEntity(
        title: Localization.of(context).fines,
        icon: Assets.icons.profile.fines,
      ),
      ProfileEntity(
        title: Localization.of(context).security,
        icon: Assets.icons.profile.security,
        onTap: () => context.pushRoute(const SecurityRoute()),
      ),
      ProfileEntity(
        title: Localization.of(context).bank_cards,
        icon: Assets.icons.profile.bankCard,
        onTap: () => context.pushRoute(const BankCardRoute()),
      ),
      ProfileEntity(
        title: Localization.of(context).insurance,
        icon: Assets.icons.profile.insurance,
      ),
      ProfileEntity(
        title: Localization.of(context).how_to_rent,
        icon: Assets.icons.profile.howRent,
      ),
      ProfileEntity(
        title: Localization.of(context).training,
        icon: Assets.icons.profile.training,
        // onTap: ()=> context.pushRoute(const Tra()),
      ),
      ProfileEntity(
        title: Localization.of(context).languageTitle,
        icon: Assets.icons.profile.language,
        onTap: () => context.pushRoute(const LanguageRoute()),
      ),
      ProfileEntity(
        title: Localization.of(context).support,
        icon: Assets.icons.profile.support,
      ),
    ];

    return BikeScaffold(
      appBar: BikeAppBar(
        title: Localization.of(context).profile,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => context.pushRoute(const UserInfoRoute()),
                child: BikeContainer(
                  borderRadius: BorderRadius.circular(24),
                  color: context.theme.whenByValue(
                    light: BikeColors.background.light.lightGray,
                    dark: BikeColors.background.dark.lightGray,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          BikeText(
                            'Альбина Рахатова',
                            style: BikeTypography.title.small,
                          ),
                          BikeText(
                            '+7 (700) 000 00 00',
                            style: BikeTypography.body.medium.copyWith(
                                color: context.theme.whenByValue(
                              light: BikeColors.text.light.secondary,
                              dark: BikeColors.text.dark.secondary,
                            )),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Assets.icons.arrowRight.svg(
                        colorFilter: context.svgColor(
                          light: BikeColors.icon.light.gray,
                          dark: BikeColors.icon.dark.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BikeContainer(
                        height: 104,
                        borderRadius: BorderRadius.circular(16),
                        color: context.theme.whenByValue(
                          light: BikeColors.background.light.lightGray,
                          dark: BikeColors.background.dark.lightGray,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BikeText(
                              Localization.of(context).wallet,
                              style: BikeTypography.title.small,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BikeText(
                                    '369 ₸',
                                    style: BikeTypography.title.large,
                                  ),
                                ),
                                Assets.icons.arrowRight.svg(
                                  colorFilter: context.svgColor(
                                    light: BikeColors.icon.light.gray,
                                    dark: BikeColors.icon.dark.gray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: BikeContainer(
                        height: 104,
                        borderRadius: BorderRadius.circular(16),
                        color: context.theme.whenByValue(
                          light: BikeColors.background.light.lightGray,
                          dark: BikeColors.background.dark.lightGray,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BikeText(
                              Localization.of(context).my_transport,
                              style: BikeTypography.title.small,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BikeText(
                                    '1',
                                    style: BikeTypography.title.large,
                                  ),
                                ),
                                Assets.icons.arrowRight.svg(
                                  colorFilter: context.svgColor(
                                    light: BikeColors.icon.light.gray,
                                    dark: BikeColors.icon.dark.gray,
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
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileElements.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: profileElements[index].onTap,
                    child: BikeContainer(
                      borderRadius: BorderRadius.circular(16),
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.lightGray,
                        dark: BikeColors.background.dark.lightGray,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          BikeContainer(
                            height: 32,
                            width: 32,
                            color: context.theme.whenByValue(
                              light: BikeColors.background.light.grey,
                              dark: BikeColors.background.dark.grey,
                            ),
                            shape: BoxShape.circle,
                            child: profileElements[index].icon.svg(),
                          ),
                          const SizedBox(width: 12),
                          BikeText(
                            profileElements[index].title,
                            style: BikeTypography.title.small,
                          ),
                          const Spacer(),
                          Assets.icons.arrowRight.svg(
                            colorFilter: context.svgColor(
                              light: BikeColors.icon.light.gray,
                              dark: BikeColors.icon.dark.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 8);
                },
              ),
              const SizedBox(height: 16),
              BikeGrayButton(
                text: Localization.of(context).logout,
                onTap: () {
                  showAttentionDialog(
                    context: context,
                    text: Localization.of(context).logout_confirmation,
                    onConfirm: () {
                      AppStorage.clear();
                      context.router.replaceAll([AuthRoute()]);
                    },
                    onCancel: () => context.maybePop(),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}



class ProfileEntity {
  final String title;
  final SvgGenImage icon;
  final Function()? onTap;

  ProfileEntity({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
