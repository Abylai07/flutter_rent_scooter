import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';

Future<void> showBiometricDialog({
  required BuildContext context,
  required SvgGenImage icon,
  required String text,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  bool isDismissible = false,
}) {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (_) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: context.theme.brightness,
          scaffoldBackgroundColor:
              BikeColors.background.light.alert, // Background color
        ),
        child: CupertinoAlertDialog(
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
                  child: icon.svg(
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      BikeColors.main.light.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                text,
                style: BikeTypography.body.large,
              )
              // Title
            ],
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onCancel,
              child: Text(
                Localization.of(context).no,
                style: BikeTypography.title.small.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.theme.whenByValue(
                    light: BikeColors.text.light.primary,
                    dark: BikeColors.text.dark.primary,
                  ),
                ),
              ),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onConfirm,
              child: Text(
                Localization.of(context).yes,
                style: BikeTypography.title.small.copyWith(
                  color: context.theme.whenByValue(
                    light: BikeColors.text.light.primary,
                    dark: BikeColors.text.dark.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
