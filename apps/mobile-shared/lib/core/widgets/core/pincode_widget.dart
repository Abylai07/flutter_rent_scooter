import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class BikePincodeWidget extends StatelessWidget {
  final String title;
  const BikePincodeWidget({
    super.key,
    required this.title,
    this.controller,
    this.errorText,
    this.onCompleted,
  });
  final String? errorText;
  final TextEditingController? controller;
  final void Function(String code)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BikeText(
          title,
          style: BikeTypography.headline.large.copyWith(
            color: context.theme.whenByValue(
              light: BikeColors.text.light.primary,
              dark: BikeColors.text.dark.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Pinput(
          onCompleted: onCompleted,
          controller: controller,
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: BikeTypography.body.large.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.primary,
                dark: BikeColors.text.dark.primary,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: context.theme.whenByValue(
                  light: BikeColors.stroke.light.main,
                  dark: BikeColors.stroke.dark.main,
                ),
              ),
              borderRadius: BikeBorderRadiuses.radius12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Opacity(
          opacity: errorText != null ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BikeText(
              errorText ?? '',
              style: BikeTypography.body.large.copyWith(
                color: context.theme.whenByValue(
                  light: BikeColors.main.light.red,
                  dark: BikeColors.main.dark.red,
                ),
              ),
              maxLines: 7,
            ),
          ),
        ),
      ],
    );
  }
}
