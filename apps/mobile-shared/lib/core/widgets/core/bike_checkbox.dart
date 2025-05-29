import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/material.dart';

class BikeCheckbox extends StatelessWidget {
  const BikeCheckbox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: value ? BikeColors.icon.light.green : Colors.transparent,
          border: Border.all(
            color: !value
                ? context.theme.whenByValue(
                    light: BikeColors.text.light.tertiary,
                    dark: BikeColors.text.dark.tertiary,
                  )
                : Colors.transparent,
          ),
          shape: BoxShape.circle,
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 12.0,
                color: context.theme.whenByValue(
                  light: Colors.white,
                  dark: BikeColors.background.dark.lightGray,
                ),
              )
            : null,
      ),
    );
  }
}
