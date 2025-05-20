import 'package:almabike_shared/almabike_shared.dart';
import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
        child: Text(text, maxLines: 3),
      ),
      backgroundColor: BikeColors.main.light.red,
    ),
  );
}
