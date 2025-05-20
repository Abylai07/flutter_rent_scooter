import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';

class BikeButton extends StatelessWidget {
  const BikeButton({
    super.key,
    required this.title,
    this.onPressed,
    this.leading,
    this.trailing,
    this.size = const BikeButtonSizeL(),
  });

  final IconData? leading;
  final VoidCallback? onPressed;
  final IBikeButtonSize size;
  final String title;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        disabledBackgroundColor: context.theme.whenByValue(
          light: BikeColors.background.light.buttonSecondary,
          dark: BikeColors.background.dark.buttonSecondary,
        ),
        disabledForegroundColor: context.theme.whenByValue(
          light: BikeColors.text.light.secondary,
          dark: BikeColors.text.dark.secondary,
        ),
        backgroundColor: context.theme.whenByValue(
          light: BikeColors.background.light.button,
          dark: BikeColors.background.dark.button,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        maximumSize: Size.fromHeight(size.height),
        foregroundColor: context.theme.whenByValue(
          light: BikeColors.background.light.primary,
          dark: BikeColors.background.dark.primary,
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: trailing != null ? Icon(leading, size: 12) : null,
            ),
            Center(
              child: BikeText(
                title,
                style: size.textStyle,
              ),
            ),
            SizedBox(
              child: trailing != null ? Icon(trailing, size: 12) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class BikeButtonSizeL implements IBikeButtonSize {
  const BikeButtonSizeL();

  @override
  double get height => 48;

  @override
  TextStyle get textStyle => BikeTypography.button.large;
}

class BikeButtonSizeM implements IBikeButtonSize {
  const BikeButtonSizeM();

  @override
  double get height => 40;

  @override
  TextStyle get textStyle => BikeTypography.button.large;
}

class BikeButtonSizeS implements IBikeButtonSize {
  const BikeButtonSizeS();

  @override
  double get height => 32;

  @override
  TextStyle get textStyle => BikeTypography.body.medium;
}

class BikeButtonSizeXS implements IBikeButtonSize {
  const BikeButtonSizeXS();

  @override
  double get height => 24;

  @override
  TextStyle get textStyle => BikeTypography.body.small;
}

abstract class IBikeButtonSize {
  double get height;
  TextStyle get textStyle;
}
