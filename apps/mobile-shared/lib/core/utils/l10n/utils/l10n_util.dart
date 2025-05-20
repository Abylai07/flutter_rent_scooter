import 'package:almabike_shared/core/utils/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Localization utility class
class LocalizationUtil extends ChangeNotifier {
  /// Singleton class with initialization
  LocalizationUtil._() {
    _locale = _localeRu;
    notifyListeners();
  }

  /// Singleton instance
  static final instance = LocalizationUtil._();

  final supportedLocales = AppLocalizations.delegate.supportedLocales;

  late Locale _locale;

  Locale get _localeEn => supportedLocales[0];
  Locale get _localeKk => supportedLocales[1];
  Locale get _localeRu => supportedLocales[2];

  /// Returns the current app locale
  Locale get locale => _locale;

  void setEn() => _set(locale: _localeEn);

  void setKk() => _set(locale: _localeKk);

  void setRu() => _set(locale: _localeRu);

  /// Changes the app locale
  void _set({required Locale locale}) {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();
  }
}
