import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

ToastController showSnackBar(BuildContext context, String text,
    {bool showError = true}) {
  return InteractiveToast.slide(
    context,
    leading: showError ? Assets.icons.error.svg() : Assets.icons.success.svg(),
    title: Text(
      text,
      style: BikeTypography.title.medium,
    ),
    onTapped: () {},
    toastStyle: ToastStyle(
        titleLeadingGap: 10,
        padding: const EdgeInsets.all(10),
        progressBarColor: showError ? BikeColors.main.light.red : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        )),
    toastSetting: const SlidingToastSetting(
      animationDuration: Duration(seconds: 1),
      displayDuration: Duration(seconds: 2),
      toastStartPosition: ToastPosition.top,
      toastAlignment: Alignment.topCenter,
      progressBarHeight: 4,
      maxHeight: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      maxWidth: double.infinity,
    ),
  );
}

/* SnackBar */
// void showSnackBarDeprecated(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       duration: const Duration(seconds: 3),
//       backgroundColor: AppColors().gray5,
//       content: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: AppTextStyles.regular16(context),
//       )));
// }
//
// // showRoundedSnackBar
// void showRoundedSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     duration: const Duration(milliseconds: 1500),
//     backgroundColor: AppColors().white,
//     behavior: SnackBarBehavior.floating,
//     margin: EdgeInsets.symmetric(
//         horizontal: 50.w, vertical: kBottomNavigationBarHeight),
//     content: Text(
//       text,
//       textAlign: TextAlign.center,
//       style: AppTextStyles.regular16(context, color: AppColors().gray1),
//     ),
//     elevation: 10,
//     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12.0),
//     ),
//   ));
// }
