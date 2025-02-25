part of 'bike_typography.dart';

class _BikeTypographyButton extends IBikeTypography {
  _BikeTypographyButton();

  TextStyle get large => baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  TextStyle get small => baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
}
