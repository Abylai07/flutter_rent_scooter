import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/navigation/route_config.dart';

@RoutePage()
class VerificationStepThreeView extends StatelessWidget {
  const VerificationStepThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      appBar: BikeAppBar(
        title: Localization.of(context).verification,
        subTitle: Localization.of(context).step_num_of_3(3),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BikeButton(
            title: Localization.of(context).start_verification,
            onPressed: () {
              context.pushRoute(const VerificationResultRoute());
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BikeText(
                Localization.of(context).upload_passport,
                style: BikeTypography.title.medium,
              ),
              BikeContainer(
                color: context.theme.whenByValue(
                  light: BikeColors.background.light.lightGray,
                  dark: BikeColors.background.dark.lightGray,
                ),
                borderRadius: BikeBorderRadiuses.radius16,
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    BikeContainer(
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.grey,
                        dark: BikeColors.background.dark.grey,
                      ),
                      shape: BoxShape.circle,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 12),
                      child: Icon(
                        BikeIcons.user,
                        size: 16,
                        color: BikeColors.icon.light.green,
                      ),
                    ),
                    Expanded(
                      child: BikeText(
                        Localization.of(context).face_control_instruction,
                        style: BikeTypography.body.medium,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              ),
              BikeContainer(
                color: context.theme.whenByValue(
                  light: BikeColors.background.light.lightGray,
                  dark: BikeColors.background.dark.lightGray,
                ),
                borderRadius: BikeBorderRadiuses.radius16,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    BikeContainer(
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.grey,
                        dark: BikeColors.background.dark.grey,
                      ),
                      shape: BoxShape.circle,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 12),
                      child: Icon(
                        BikeIcons.people,
                        size: 16,
                        color: BikeColors.icon.light.green,
                      ),
                    ),
                    Expanded(
                      child: BikeText(
                        Localization.of(context).no_objects_background,
                        style: BikeTypography.body.medium,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
