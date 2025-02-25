import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/style/tokens/bike_shadows.dart';
import 'package:flutter/material.dart';

class BikeContainer extends StatelessWidget {
  const BikeContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.shape = BoxShape.rectangle,
  });

  final BorderRadius? borderRadius;
  final Widget child;
  final Color? color;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: borderRadius,
        boxShadow: BikeShadows.primary,
        color: color ??
            context.theme.whenByValue(
              light: BikeColors.background.light.primary,
              dark: BikeColors.background.dark.primary,
            ),
      ),
      child: Center(child: child),
    );
  }
}
