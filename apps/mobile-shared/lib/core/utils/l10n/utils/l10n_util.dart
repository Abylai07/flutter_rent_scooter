import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Localization utility class
class LocalizationUtil extends ChangeNotifier {
  /// Singleton class with initialization
  LocalizationUtil._() {
    _locale = Locale(AppStorage.locale);
    notifyListeners();
  }

  /// Singleton instance
  static final instance = LocalizationUtil._();

  final supportedLocales = AppLocalizations.delegate.supportedLocales;

  late Locale _locale;

  Locale get _localeRu => supportedLocales[0];
  Locale get _localeEn => supportedLocales[1];
  Locale get _localeKk => supportedLocales[2];

  /// Returns the current app locale
  Locale get locale => _locale;

  void setEn() => set(locale: _localeEn);

  void setKk() => set(locale: _localeKk);

  void setRu() => set(locale: _localeRu);

  /// Changes the app locale
  void set({required Locale locale}) {
    if (_locale == locale) return;
    AppStorage.locale = locale.languageCode;
    _locale = locale;
    notifyListeners();
  }
}
