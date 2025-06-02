import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:almabike_shared/gen/fonts.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

@RoutePage()
class VerificationResultView extends StatelessWidget {
  const VerificationResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Assets.logos.logo.svg(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BikeText(
              Localization.of(context).verification_in_progress,
              style: BikeTypography.headline.medium,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 40),
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 24.0,
                animation: true,
                percent: 0.25,
                center: BikeText(
                  "25%",
                  style: TextStyle(
                    fontFamily: FontFamily.onest,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: context.theme.whenByValue(
                      light: BikeColors.text.light.secondary,
                      dark: BikeColors.text.dark.secondary,
                    ),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: context.theme.whenByValue(
                  light: BikeColors.background.light.grey,
                  dark: BikeColors.background.dark.grey,
                ),
                progressColor: BikeColors.main.light.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BikeText(
                Localization.of(context).do_not_close,
                style: BikeTypography.body.large.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.text.light.secondary,
                    dark: BikeColors.text.dark.secondary,
                  ),
                ),
                maxLines: 5,
                align: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(height: kBottomNavigationBarHeight),
    );
  }
}
