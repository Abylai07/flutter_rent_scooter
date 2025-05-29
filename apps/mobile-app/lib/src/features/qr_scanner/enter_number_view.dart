import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

@RoutePage()
class EnterNumberView extends StatelessWidget {
  const EnterNumberView({super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController controller = TextEditingController();
    final MaskTextInputFormatter mask =  MaskTextInputFormatter(
      mask: '### ### ###',
      filter: {'#': RegExp(r'[0-9]')},
    );

    return BikeScaffold(
      appBar: const BikeAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BikeText(
                Localization.of(context).enter_phone_number,
                style: BikeTypography.headline.large.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.text.light.primary,
                    dark: BikeColors.text.dark.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              BikeTextField(
                controller: controller,
                title: Localization.of(context).number,
                hintText: '000 000',
                inputFormatters: [mask],
                keyboardType: TextInputType.number,
                errorText: null,
              ),
              const SizedBox(height: 32),
              BikeButton(
                title: Localization.of(context).get_code,
                onPressed: () {
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: kBottomNavigationBarHeight),
    );
  }
}
