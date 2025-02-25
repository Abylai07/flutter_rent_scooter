import 'package:flutter/material.dart';

part '_background_colors.dart';
part '_main_colors.dart';
part '_stroke_colors.dart';
part '_static_colors.dart';
part '_icon_colors.dart';
part '_text_colors.dart';

/// Colors for entire project
class BikeColors {
  static const background = _BackgroundColors();
  static const icon = _IconColors();
  static const main = _MainColors();
  static const staticColors = _StaticColors();
  static const stroke = _StrokeColors();
  static const text = _TextColors();
}
