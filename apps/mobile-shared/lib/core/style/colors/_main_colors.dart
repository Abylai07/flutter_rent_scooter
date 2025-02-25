part of 'colors.dart';

class _MainColors {
  const _MainColors();

  _MainDarkColors get dark => _MainDarkColors();
  _MainLightColors get light => _MainLightColors();
}

class _MainDarkColors extends _MainColors {
  final Color blue = const Color(0xFF1D89A7);
  final Color primary = const Color(0xFF22A778);
  final Color red = const Color(0xFFF33A72);
  final Color yellow = const Color(0xFFFFD600);
}

class _MainLightColors extends _MainColors {
  final Color blue = const Color(0xFF134D69);
  final Color primary = const Color(0xFF22A778);
  final Color red = const Color(0xFFF33A72);
  final Color yellow = const Color(0xFFFFD600);
}
