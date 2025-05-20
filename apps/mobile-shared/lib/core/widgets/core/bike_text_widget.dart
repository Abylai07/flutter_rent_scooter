import 'package:flutter/material.dart';

class BikeText extends StatelessWidget {
  const BikeText(
    this.title, {
    super.key,
    this.style,
    this.maxLines,
    this.align,
  });

  final int? maxLines;
  final TextStyle? style;
  final String title;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: align,
    );
  }
}
