import 'package:almabike_shared/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
part '_headline_typography.dart';
part '_title_typography.dart';
part '_body_typography.dart';
part '_button_typography.dart';

class BikeTypography {
  BikeTypography._();

  static final body = _BikeTypographyBody();
  static final button = _BikeTypographyButton();
  static final headline = _BikeTypographyHeadline();
  static final title = _BikeTypographyTitle();
}

abstract interface class IBikeTypography {
  final baseStyle = const TextStyle(
    fontFamily: FontFamily.onest,
  );
}
