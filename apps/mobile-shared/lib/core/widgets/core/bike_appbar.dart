import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// App Bar widget for whole project
class BikeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BikeAppBar({super.key, this.subTitle, required this.title, this.actions});

  /// Subtitle of the app bar
  final String? subTitle;

  /// Title of the app bar
  final String title;

  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.whenByValue(
        light: BikeColors.background.light.primary,
        dark: BikeColors.background.dark.primary,
      ),
      iconTheme: IconThemeData(
        weight: 100,
        color: context.theme.whenByValue(
          light: BikeColors.icon.light.black,
          dark: BikeColors.icon.dark.white,
        ),
      ),
      title: Column(
        children: [
          BikeText(
            title,
            style: BikeTypography.headline.small.copyWith(
              color: context.theme.whenByValue(
                light: BikeColors.text.light.primary,
                dark: BikeColors.text.dark.primary,
              ),
            ),
          ),
          if (subTitle != null)
            Text(
              subTitle!,
              style: BikeTypography.button.small.copyWith(
                color: context.theme.whenByValue(
                  light: BikeColors.text.light.secondary,
                  dark: BikeColors.text.dark.secondary,
                ),
              ),
            ),
        ],
      ),
      actions: actions,
    );
  }
}
