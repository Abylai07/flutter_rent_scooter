import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.withShadow,
    this.margin,
    this.isLoading = false,
    required this.onTap,
    this.child,
    this.buttonStyle,
  });
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onTap;
  final bool? withShadow;
  final EdgeInsets? margin;
  final bool isLoading;
  final Widget? child;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              elevation: withShadow == false ? 0 : null,
              shadowColor: withShadow == false ? Colors.transparent : null,
              minimumSize: Size(MediaQuery.of(context).size.width, 48),
              backgroundColor: backgroundColor ?? BikeColors.main.light.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox(
                  height: 22.0,
                  width: 22.0,
                  child: CircularProgressIndicator(),
                )
              : child ??
                  Text(
                    text,
                    style: BikeTypography.title.small.copyWith(
                      color: onTap == null
                          ? BikeColors.background.light.buttonSecondary
                          : textColor ?? BikeColors.background.light.primary,
                    ),
                  ),
        ),
      ),
    );
  }
}
