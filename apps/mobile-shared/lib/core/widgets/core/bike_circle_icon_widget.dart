import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BikeCircleIconWidget extends StatelessWidget {
  const BikeCircleIconWidget({
    super.key,
    this.icon,
    this.child,
  });
  final SvgGenImage? icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BikeContainer(
      shape: BoxShape.circle,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 12),
      color: context.theme.whenByValue(
        light: BikeColors.background.light.grey,
        dark: BikeColors.background.dark.grey,
      ),
      child: icon != null ? icon!.svg(
        height: 16,
        width: 16,
        colorFilter: context.svgColor(
          light: BikeColors.icon.light.green,
          dark: BikeColors.icon.dark.green,
        ),
      ) : child ?? const SizedBox(),
    );
  }
}