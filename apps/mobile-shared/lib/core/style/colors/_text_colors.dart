part of 'colors.dart';

class _TextColors {
  const _TextColors();

  _TextDarkColors get dark => _TextDarkColors();
  _TextLightColors get light => _TextLightColors();
}

class _TextDarkColors extends _TextColors {
  final Color primary = const Color(0xFFFFFFFF);
  final Color secondary = const Color(0xFF979797);
  final Color tertiary = const Color(0xFF565656);
  final Color green = const Color(0xFF849D65);
}

class _TextLightColors extends _TextColors {
  final Color primary = const Color(0xFF171717);
  final Color secondary = const Color(0xFF6E747A);
  final Color tertiary = const Color(0xFFCFD0D0);
  final Color green = const Color(0xFF849D65);
  final Color red = const Color(0xFFF85C50);
}
