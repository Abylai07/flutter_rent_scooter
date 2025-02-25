import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/material.dart';

/// Scaffold widget for whole project
class BikeScaffold extends StatelessWidget {
  const BikeScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.botSafeArea = false,
    this.topSafeArea = false,
    this.bottomNavigationBar,
    this.bgColor,
  });

  /// App bar widget
  final BikeAppBar? appBar;

  /// Child widget
  final Widget body;

  /// Safe area for bottom
  final bool botSafeArea;

  /// Bottom navigation bar widget
  final Widget? bottomNavigationBar;

  /// Safe area for top
  final bool topSafeArea;

  /// Nullable background color
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: SafeArea(
        top: topSafeArea,
        bottom: botSafeArea,
        child: Scaffold(
          backgroundColor: bgColor ??
              context.theme.whenByValue(
                light: BikeColors.background.light.primary,
                dark: BikeColors.background.dark.primary,
              ),
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
