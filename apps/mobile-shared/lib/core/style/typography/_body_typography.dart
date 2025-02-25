part of 'bike_typography.dart';

class _BikeTypographyBody extends IBikeTypography {
  _BikeTypographyBody();

  TextStyle get large => baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get medium => baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  TextStyle get small => baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
