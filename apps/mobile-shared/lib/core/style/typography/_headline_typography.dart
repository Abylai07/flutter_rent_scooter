part of 'bike_typography.dart';

class _BikeTypographyHeadline extends IBikeTypography {
  _BikeTypographyHeadline();

  TextStyle get large => baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  TextStyle get medium => baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  TextStyle get small => baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );
}
