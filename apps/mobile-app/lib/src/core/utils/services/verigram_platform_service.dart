import 'dart:async';

import 'package:flutter/services.dart';

class VerigramPlatformService {

  late MethodChannel veridocMethodChannel;
  late MethodChannel veriliveMethodChannel;

  VerigramPlatformService({
    required Function(dynamic object) onSuccessCall,
    required Function() onCancel,
    required Function() onFailed,
  }) {
    Future<void> defaultMethodCallHandler(MethodCall call) async {
      String viewType = "none";

      if (call.method == 'sendVeridocResult') {
        onSuccessCall.call(call.arguments);
        viewType = "<veridoc-platform-view>";
      } else if (call.method == 'sendVeriliveResult') {
        onSuccessCall.call(call.arguments);
        viewType = '<verilive-platform-view>';
      } else if (call.method == 'sendVeridocCancel') {
        // onCancelStream.add(call);
        onCancel.call();
      } else if (call.method == 'sendVeriliveFailed') {
        onFailed.call();
        // onFailedStream.add(call);
      } else if (viewType != 'none') {
        // onSuccessStream.add(call.arguments);
        onSuccessCall.call(call.arguments);
      } else {
        onFailed.call();
      }
    }

    veridocMethodChannel = const MethodChannel("veridocChannel");
    veridocMethodChannel.setMethodCallHandler(defaultMethodCallHandler);

    veriliveMethodChannel = const MethodChannel("veriliveChannel");
    veriliveMethodChannel.setMethodCallHandler(defaultMethodCallHandler);
  }

  Future<void> invokeVeridocNativeStart() async {
    try {
      await veridocMethodChannel.invokeMethod('start');
    } on PlatformException catch (e) {
      print("Failed to start document recognition process: '${e.message}'.");
    }
  }

  Future<void> invokeVeridocNativeStop() async {
    try {
      await veridocMethodChannel.invokeMethod('stop');
    } on PlatformException catch (e) {
      print("Failed to stop document recognition process: '${e.message}'.");
    }
  }

  Future<void> invokeVeridocNativeRetry() async {
    try {
      await veridocMethodChannel.invokeMethod('retry');
    } on PlatformException catch (e) {
      print("Failed to retry document recognition process: '${e.message}'.");
    }
  }

  Future<void> invokeVeriliveNativeStart() async {
    try {
      await veriliveMethodChannel.invokeMethod('start');
    } on PlatformException catch (e) {
      print("Failed to start liveness detection process: '${e.message}'.");
    }
  }

  Future<void> invokeVeriliveNativeStop() async {
    try {
      await veriliveMethodChannel.invokeMethod('stop');
    } on PlatformException catch (e) {
      print("Failed to stop liveness detection process: '${e.message}'.");
    }
  }
}
