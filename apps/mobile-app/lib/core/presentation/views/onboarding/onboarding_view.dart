import 'package:almabike_app/core/presentation/utils/navigation/route_config.gr.dart';
import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: AspectRatio(
                  aspectRatio: 328 / 240,
                  child: const Placeholder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final i in pages)
                    Container(
                      margin: isLastPage(page: i)
                          ? null
                          : const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BikeBorderRadiuses.radius12,
                        color: isPageSelected(page: i)
                            ? context.theme.whenByValue(
                                light: BikeColors.main.light.primary,
                                dark: BikeColors.main.dark.primary,
                              )
                            : context.theme.whenByValue(
                                light: BikeColors.icon.light.grey,
                                dark: BikeColors.icon.dark.grey,
                              ),
                      ),
                      child: SizedBox(
                        width: isPageSelected(page: i) ? 20 : 4,
                        height: 4,
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: BikeText(
                  'Добро пожаловать в Almaty Bike',
                  style: BikeTypography.headline.medium.copyWith(
                    color: context.theme.whenByValue(
                      light: BikeColors.text.light.primary,
                      dark: BikeColors.text.dark.primary,
                    ),
                  ),
                ),
              ),
              for (final i in [1, 2, 3, 4])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.whenByValue(
                              light: BikeColors.main.light.primary,
                              dark: BikeColors.main.dark.primary,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: BikeText(
                            'Быстрый, удобный и экологичный способ передвижения!',
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
      fab: Padding(
        padding: const EdgeInsets.all(16),
        child: BikeButton(
          title: buttonTitle,
          onPressed: nextPage,
        ),
      ),
    );
  }

  String get buttonTitle =>
      isLastPage(page: selectedPage) ? 'Начать поездку' : 'Далее';
  List<int> get pages => [1, 2, 3, 4];

  bool isLastPage({required int page}) => page == pages.last;

  bool isPageSelected({required int page}) => page == selectedPage;

  void nextPage() {
    if (selectedPage != pages.last) {
      setState(() {
        selectedPage++;
      });
    } else {
      AutoRouter.of(context).replace(AuthRoute());
    }
  }
}
