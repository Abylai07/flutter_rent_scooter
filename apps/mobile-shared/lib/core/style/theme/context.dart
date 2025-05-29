// ignore_for_file: public_member_api_docs

import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  bool get isDark => theme.brightness == Brightness.dark;
  bool get isLight => theme.brightness == Brightness.light;
}

extension SvgColorFilterExtension on BuildContext {
  ColorFilter svgColor({
    required Color light,
    required Color dark,
  }) {
    return ColorFilter.mode(
      theme.whenByValue(light: light, dark: dark),
      BlendMode.srcIn,
    );
  }
}


