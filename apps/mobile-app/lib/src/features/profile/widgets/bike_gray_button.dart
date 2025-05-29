import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/colors/colors.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';

class BikeGrayButton extends StatelessWidget {
  const BikeGrayButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.whenByValue(
              light: BikeColors.background.light.lightGray,
              dark: BikeColors.background.dark.lightGray),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onTap,
        child: BikeText(
          text,
          style: BikeTypography.title.small.copyWith(
            color: BikeColors.text.light.red,
          ),
        ),
      ),
    );
  }
}