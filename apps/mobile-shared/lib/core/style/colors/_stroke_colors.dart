part of 'colors.dart';

class _StrokeColors {
  const _StrokeColors();

  _StrokeDarkColors get dark => _StrokeDarkColors();
  _StrokeLightColors get light => _StrokeLightColors();
}

class _StrokeDarkColors extends _StrokeColors {
  final Color main = const Color(0xFF282A2D);
}

class _StrokeLightColors extends _StrokeColors {
  final Color main = const Color(0xFFEBEBEB);
}
