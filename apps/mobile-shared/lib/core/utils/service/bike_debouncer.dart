import 'dart:async';

import 'package:flutter/material.dart';

class BikeDebouncer {
  BikeDebouncer({this.milliseconds = 300});

  final int milliseconds;

  VoidCallback? _lastAction;
  Timer? _timer;

  void dispose({bool executeLast = false}) {
    if (executeLast && _lastAction != null) {
      _lastAction?.call();
    }
    _timer?.cancel();
    _lastAction = null;
  }

  void run(VoidCallback action) {
    _lastAction = action;
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _lastAction?.call();
      _lastAction = null;
    });
  }
}
