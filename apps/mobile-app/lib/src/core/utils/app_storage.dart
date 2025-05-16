import 'dart:io';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  AppStorage._();

  static final AppStorage instance = AppStorage._();
  final _box = GetStorage();

  static const _accessToken = '_accessToken';
  static const _refreshToken = '_refreshToken';
  static const _fcmToken = '_fcmToken';
  static const _isAuth = '_isAuth';
  static const _language = 'language';
  static const _id = '_id';

  T? _getValue<T>(String key) => _box.read<T>(key);
  void _setValue<T>(String key, T value) => _box.write(key, value);
  void _removeKey(String key) => _box.remove(key);

  String? get accessToken => _getValue<String>(_accessToken);
  set accessToken(String? value) => value != null ? _setValue(_accessToken, value) : null;

  String? get refreshToken => _getValue<String>(_refreshToken);
  set refreshToken(String? value) => value != null ? _setValue(_refreshToken, value) : null;

  String? get id => _getValue<String>(_id);
  set id(String? value) => value != null ? _setValue(_id, value) : null;

  String get locale => _getValue<String>(_language) ?? _getSystemLocale();
  set locale(String value) => _setValue(_language, value);

  bool get isAuth => _getValue<bool>(_isAuth) ?? false;
  set isAuth(bool value) => _setValue(_isAuth, value);

  String? get fcmToken => _getValue<String>(_fcmToken);
  set fcmToken(String? value) => value != null ? _setValue(_fcmToken, value) : null;

  void clear() => _box.erase();

  String _getSystemLocale() {
    final locale = Platform.localeName.split('_').first;
    return ['ru', 'en', 'kk'].contains(locale) ? locale : 'en';
  }
}
