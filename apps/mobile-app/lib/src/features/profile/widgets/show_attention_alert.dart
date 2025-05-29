import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';

Future<void> showAttentionDialog({
  required BuildContext context,
  required String text,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  String? buttonText,
  Color? buttonColor,
  bool isDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (_) {
      return AlertDialog(
        backgroundColor: context.theme.whenByValue(light: BikeColors.background.light.lightGray, dark: BikeColors.background.dark.lightGray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.whenByValue(
                    light: BikeColors.background.light.grey,
                    dark: BikeColors.background.dark.grey),
              ),
              child: Center(
                child: Assets.icons.attention.svg(
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: BikeTypography.body.large,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          Container(
            height: 1,
            color: context.theme.whenByValue(
              light: BikeColors.background.light.grey,
              dark: BikeColors.background.dark.grey,
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      Localization.of(context).cancel_short,
                      style: BikeTypography.title.small.copyWith(
                        color: context.theme.whenByValue(
                          light: BikeColors.text.light.primary,
                          dark: BikeColors.text.dark.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: context.theme.whenByValue(
                    light: BikeColors.background.light.grey,
                    dark: BikeColors.background.dark.grey,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: onConfirm,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      buttonText ?? Localization.of(context).logout,
                      style: BikeTypography.title.small.copyWith(
                        color: buttonColor ?? BikeColors.text.light.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
