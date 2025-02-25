part of 'colors.dart';

class _IconColors {
  const _IconColors();

  _IconDarkColors get dark => _IconDarkColors();
  _IconLightColors get light => _IconLightColors();
}

class _IconDarkColors extends _IconColors {
  final Color green = const Color(0xFF22A778);
  final Color grey = const Color(0xFF7E8080);
  final Color white = const Color(0xFF171717);
}

class _IconLightColors extends _IconColors {
  final Color green = const Color(0xFF22A778);
  final Color grey = const Color(0xFFCFD0D0);
  final Color white = const Color(0xFFFFFFFF);
}
