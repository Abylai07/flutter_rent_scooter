import 'dart:io';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final _box = GetStorage();

  static const _accessToken = '_accessToken';
  static const _refreshToken = '_refreshToken';
  static const _fcmToken = '_fcmToken';
  static const _isAuth = '_isAuth';
  static const _isOnboarded = '_isOnboarded';
  static const _language = 'language';
  static const _id = '_id';
  static const _authByBiometrics = '_authByBiometrics';

  static T? _getValue<T>(String key) => _box.read<T>(key);
  static void _setValue<T>(String key, T value) => _box.write(key, value);
  static void _removeKey(String key) => _box.remove(key);

  static String? get accessToken => _getValue<String>(_accessToken);
  static set accessToken(String? value) {
    if (value != null) _setValue(_accessToken, value);
  }

  static String? get refreshToken => _getValue<String>(_refreshToken);
  static set refreshToken(String? value) {
    if (value != null) _setValue(_refreshToken, value);
  }

  static String? get id => _getValue<String>(_id);
  static set id(String? value) {
    if (value != null) _setValue(_id, value);
  }

  static String get locale => _getValue<String>(_language) ?? _getSystemLocale();
  static set locale(String value) => _setValue(_language, value);

  static bool get isAuth => _getValue<bool>(_isAuth) ?? false;
  static set isAuth(bool value) => _setValue(_isAuth, value);

  static bool get isOnboarded => _getValue<bool>(_isOnboarded) ?? false;
  static set isOnboarded(bool value) => _setValue(_isOnboarded, value);

  static bool get authByBiometrics => _getValue<bool>(_authByBiometrics) ?? false;
  static set authByBiometrics(bool value) => _setValue(_authByBiometrics, value);

  static String? get fcmToken => _getValue<String>(_fcmToken);
  static set fcmToken(String? value) {
    if (value != null) _setValue(_fcmToken, value);
  }

  static void clear() => _box.erase();

  static String _getSystemLocale() {
    final locale = Platform.localeName.split('_').first;
    return ['ru', 'en', 'kk'].contains(locale) ? locale : 'en';
  }
}
