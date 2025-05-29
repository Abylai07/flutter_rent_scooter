import 'dart:async';

import 'package:almabike_shared/core/utils/app_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<String?> readCode() async {
    try {
      return await _storage.read(key: 'pin');
    } catch (e) {
      await clearStorage();
      debugPrint('Error reading PIN: $e');
      return null; // Return null or handle the error appropriately
    }
  }

  static Future<void> clearStorage() async {
    await _storage.deleteAll();
    cancelAuthentication();
  }

  static Future<void> writeCode(String value) async {
    await _storage.write(key: 'pin', value: value);
  }

  static Future<bool> verifyCode(String enteredCode) async {
    final pin = await readCode();
    if (pin == enteredCode) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  static Future<bool> authenticateWithBiometrics(String desc) async {
    try {
      return await _auth.authenticate(
        localizedReason: desc,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: kReleaseMode,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('authenticateWithBiometrics $e');
      return false;
    }
  }

  static Future<void> cancelAuthentication() async {
    AppStorage.authByBiometrics = false;
    await _auth.stopAuthentication();
  }

  static Future<bool> hasBiometrics() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } on PlatformException {
      return false;
    }
  }
}
