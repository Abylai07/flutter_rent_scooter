part of 'colors.dart';

class _IconColors {
  const _IconColors();

  _IconDarkColors get dark => _IconDarkColors();
  _IconLightColors get light => _IconLightColors();
}

class _IconDarkColors extends _IconColors {
  final Color green = const Color(0xFF849D65);
  final Color grey = const Color(0xFF7E8080);
  final Color black = const Color(0xFF000000);
  final Color white = const Color(0xFFFFFFFF);

}

class _IconLightColors extends _IconColors {
  final Color green = const Color(0xFF849D65);
  final Color grey = const Color(0xFFCFD0D0);
  final Color black = const Color(0xFF000000);
  final Color white = const Color(0xFFFFFFFF);
}
