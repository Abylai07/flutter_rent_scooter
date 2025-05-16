import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../colors/colors.dart';

/// Util class to maintain the app theme
class ThemeUtil extends ChangeNotifier {
  /// Singleton class with initialization
  ThemeUtil._() {
    _init();
  }

  /// Singleton instance
  static final instance = ThemeUtil._();

  late ThemeData _theme;

  ThemeData get _darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: BikeColors.main.dark.primary,
    colorScheme: ColorScheme.dark(primary: BikeColors.main.dark.primary),
  );

  ThemeData get _lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: BikeColors.main.dark.primary,
    colorScheme: ColorScheme.light(primary: BikeColors.main.dark.primary),
  );

  /// Returns true if the current theme is dark
  bool get isDark => _theme == _darkTheme;

  /// Returns the current theme
  ThemeData get theme => _theme;

  void changeTheme() => _set();

  /// Initializes the theme based on the system theme
  void _init() {
    final platformDispatcher = SchedulerBinding.instance.platformDispatcher;
    final brightness = platformDispatcher.platformBrightness;

    bool isDarkMode = brightness == Brightness.dark;
    _theme = isDarkMode ? _darkTheme : _lightTheme;

    notifyListeners();
  }

  /// Changes the app theme
  void _set() {
    final newTheme = theme == _lightTheme ? _darkTheme : _lightTheme;

    _theme = newTheme;
    notifyListeners();
  }
}
