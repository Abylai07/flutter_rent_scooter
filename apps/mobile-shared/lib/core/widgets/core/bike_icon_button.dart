import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_container.dart';
import 'package:flutter/material.dart';

class BikeIconButton extends StatelessWidget {
  const BikeIconButton({
    super.key,
    required this.icon,
    this.color,
    this.onPressed,
    this.size = const BikeIconButtonSizeS(),
    this.iconSize,
  });

  final Color? color;
  final IconData icon;
  final VoidCallback? onPressed;
  final IBikeIconButtonSize size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return BikeContainer(
      height: size.dimension,
      width: size.dimension,
      shape: BoxShape.circle,
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: context.theme.whenByValue(
            light: WidgetStateProperty.all(BikeColors.background.light.primary),
            dark: WidgetStateProperty.all(BikeColors.background.dark.primary),
          ),
          iconSize: WidgetStateProperty.all(size.iconSize),
          iconColor: WidgetStateProperty.all(color),
        ),
        icon: Icon(icon, size: iconSize),
      ),
    );
  }
}

class BikeIconButtonSizeL implements IBikeIconButtonSize {
  const BikeIconButtonSizeL();

  @override
  double get dimension => 40;

  @override
  double get iconSize => 16;
}

class BikeIconButtonSizeS implements IBikeIconButtonSize {
  const BikeIconButtonSizeS();

  @override
  double get dimension => 24;

  @override
  double get iconSize => 8;
}

abstract class IBikeIconButtonSize {
  double get dimension;
  double get iconSize;
}
