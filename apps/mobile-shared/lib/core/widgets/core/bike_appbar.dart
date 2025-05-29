import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// App Bar widget for whole project
class BikeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BikeAppBar({
    super.key,
    this.subTitle,
    required this.title,
    this.actions,
    this.onPressed,
  });

  /// Subtitle of the app bar
  final String? subTitle;

  /// Title of the app bar
  final String title;

  final List<Widget>? actions;

  final VoidCallback? onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context) ? IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Assets.icons.arrowBack.svg(
            colorFilter: context.svgColor(
          light: BikeColors.icon.light.black,
          dark: BikeColors.icon.dark.white,
        )),
      ) : const SizedBox(),
      backgroundColor: context.theme.whenByValue(
        light: BikeColors.background.light.primary,
        dark: BikeColors.background.dark.primary,
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
