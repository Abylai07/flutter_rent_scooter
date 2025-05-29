import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/widgets/core/bike_button.dart';
import 'package:almabike_shared/core/widgets/core/bike_text_widget.dart';
import 'package:flutter/material.dart';

class BikeOutlineButton extends StatelessWidget {
  const BikeOutlineButton({
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
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        maximumSize: Size.fromHeight(size.height),
        foregroundColor: BikeColors.main.light.primary,
        side: BorderSide(
          color: BikeColors.main.light.primary,
          width: 1,
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: leading != null ? Icon(leading, size: 12) : null,
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
