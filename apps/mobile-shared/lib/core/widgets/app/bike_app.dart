import 'package:almabike_shared/core/style/theme/theme_util.dart';
import 'package:almabike_shared/core/utils/l10n/generated/app_localizations.dart';
import 'package:almabike_shared/core/utils/l10n/utils/l10n_util.dart';
import 'package:almabike_shared/core/widgets/core/state/bike_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Material App Widget
/// with localization support
class BikeApp extends StatelessWidget {
  const BikeApp({
    super.key,
    required this.routerConfig,
    required this.appTitle,
  });

  /// Title of material app
  final String appTitle;

  /// Route config
  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context) {
    return BikeProviders(
      child: Consumer<LocalizationUtil>(builder: (context, localization, _) {
        return Consumer<ThemeUtil>(
          builder: (context, theme, _) => MaterialApp.router(
            routerConfig: routerConfig,
            title: appTitle,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localization.locale,
            theme: theme.theme,
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    );
  }
}
