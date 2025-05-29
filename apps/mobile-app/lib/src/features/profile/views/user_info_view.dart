import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../verification/widgets/text_field_info_widget.dart';
import '../widgets/bike_gray_button.dart';
import '../widgets/show_attention_alert.dart';

@RoutePage()
class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BikeScaffold(
      appBar: BikeAppBar(title: Localization.of(context).personalInfo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.whenByValue(
                        light: BikeColors.background.light.secondary,
                        dark: BikeColors.background.dark.secondary,
                      ),
                    ),
                    child: const SizedBox(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.theme.whenByValue(
                            light: BikeColors.background.light.button,
                            dark: BikeColors.background.dark.button,
                          ),
                          border: Border.all(
                              width: 2,
                              color: context.theme.whenByValue(
                                light: BikeColors.background.light.primary,
                                dark: BikeColors.background.dark.primary,
                              ))),
                      child: Center(
                        child: Assets.icons.redact.svg(
                            height: 16,
                            width: 16,
                            colorFilter: context.svgColor(
                              light: BikeColors.background.light.primary,
                              dark: BikeColors.background.dark.primary,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: BikeTextField(
                title: Localization.of(context).full_name,
                hintText: Localization.of(context).full_name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: BikeTextField(
                title: Localization.of(context).phone_number,
                hintText: '+7 (000) 000 00 00',
              ),
            ),
            TextFieldInfoWidget(
              label: Localization.of(context).iin,
              text: '715864486548',
            ),
            TextFieldInfoWidget(
              label: Localization.of(context).document_number,
              text: '715864486548',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BikeButton(
                onPressed: () {},
                title: Localization.of(context).save,
              ),
            ),
            BikeGrayButton(
              text: Localization.of(context).deleteAccount,
              onTap: () {
                showAttentionDialog(
                  context: context,
                  buttonText: Localization.of(context).confirmDelete,
                  text: Localization.of(context).deleteAccountConfirmation,
                  onConfirm: () {},
                  onCancel: () => context.maybePop(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
