part of 'colors.dart';

class _BackgroundColors {
  const _BackgroundColors();

  _BackgroundDarkColors get dark => _BackgroundDarkColors();
  _BackgroundLightColors get light => _BackgroundLightColors();
}

class _BackgroundDarkColors extends _BackgroundColors {
  final Color button = const Color(0xFF849D65);
  final Color buttonSecondary = const Color(0xFF2F3235);
  final Color element = const Color(0xFF282A2D);
  final Color primary = const Color(0xFF212226);
  final Color secondary = const Color(0xFFF9F9F9);
}

class _BackgroundLightColors extends _BackgroundColors {
  final Color button = const Color(0xFF849D65);
  final Color buttonSecondary = const Color(0xFFF9F9F9);
  final Color element = const Color(0xFFF9F9F9);
  final Color primary = const Color(0xFFFFFFFF);
  final Color secondary = const Color(0xFFF9F9F9);
}
