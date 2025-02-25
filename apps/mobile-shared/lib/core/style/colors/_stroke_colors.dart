part of 'colors.dart';

class _StrokeColors {
  const _StrokeColors();

  _StrokeDarkColors get dark => _StrokeDarkColors();
  _StrokeLightColors get light => _StrokeLightColors();
}

class _StrokeDarkColors extends _StrokeColors {
  final Color main = const Color(0xFF3A3A3A);
}

class _StrokeLightColors extends _StrokeColors {
  final Color main = const Color(0xFFEBEBEB);
}
