import 'package:flutter/material.dart';

class BikeShadows {
  static List<BoxShadow> get primary => <BoxShadow>[shadow];
  static BoxShadow get shadow => const BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 4),
        spreadRadius: 0,
        blurRadius: 4,
      );
}
