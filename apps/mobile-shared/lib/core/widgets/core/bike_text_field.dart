import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_border_radiuses.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BikeTextField extends StatelessWidget {
  const BikeTextField({
    super.key,
    this.hintText,
    this.prefixText,
    this.title,
    this.inputFormatters,
    this.keyboardType,
  });

  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: BikeText(
              title!,
              style: BikeTypography.button.small.copyWith(
                color: context.theme.whenByValue(
                  light: BikeColors.text.light.secondary,
                  dark: BikeColors.text.dark.secondary,
                ),
              ),
            ),
          ),
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            hintStyle: BikeTypography.body.large.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.secondary,
                dark: BikeColors.text.dark.secondary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BikeBorderRadiuses.radius20,
              borderSide: BorderSide(
                color: context.theme.whenByValue(
                  light: BikeColors.stroke.light.main,
                  dark: BikeColors.stroke.dark.main,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BikeBorderRadiuses.radius20,
              borderSide: BorderSide(
                color: context.theme.whenByValue(
                  light: BikeColors.stroke.light.main,
                  dark: BikeColors.stroke.dark.main,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BikeBorderRadiuses.radius20,
              borderSide: BorderSide(
                color: context.theme.whenByValue(
                  light: BikeColors.stroke.light.main,
                  dark: BikeColors.stroke.dark.main,
                ),
              ),
            ),
            hintText: hintText,
            prefix: prefixText != null
                ? BikeText(
                    prefixText!,
                    style: BikeTypography.body.large.copyWith(
                      color: context.theme.whenByValue(
                        light: BikeColors.text.light.primary,
                        dark: BikeColors.text.dark.primary,
                      ),
                    ),
                  )
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelAlignment: FloatingLabelAlignment.center,
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
