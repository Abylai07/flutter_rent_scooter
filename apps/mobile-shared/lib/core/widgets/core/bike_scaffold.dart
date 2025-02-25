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
    this.fab,
  });

  /// App bar widget
  final BikeAppBar? appBar;

  /// Child widget
  final Widget body;

  /// Safe area for bottom
  final bool botSafeArea;

  /// Floating action button
  final Widget? fab;

  /// Safe area for top
  final bool topSafeArea;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: SafeArea(
        top: topSafeArea,
        bottom: botSafeArea,
        child: Scaffold(
          backgroundColor: context.theme.whenByValue(
            light: BikeColors.background.light.primary,
            dark: BikeColors.background.dark.primary,
          ),
          appBar: appBar,
          body: body,
          floatingActionButton: fab,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
