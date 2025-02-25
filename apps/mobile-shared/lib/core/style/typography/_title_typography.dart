part of 'bike_typography.dart';

class _BikeTypographyTitle extends IBikeTypography {
  _BikeTypographyTitle();

  TextStyle get large => baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      );

  TextStyle get medium => baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  TextStyle get small => baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
}
