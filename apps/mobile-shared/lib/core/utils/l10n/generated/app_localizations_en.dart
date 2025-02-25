// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get enter_phone_number => 'Введите номер телефона';

  @override
  String get phone_number => 'Номер телефона';

  @override
  String get get_code => 'Получить код';

  @override
  String resend_code_in(int seconds) {
    return 'Отправить код через 00:$seconds';
  }

  @override
  String pageHomeInboxCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count new messages',
      one: 'You have 1 new message',
      zero: 'You have no new messages',
    );
    return '$_temp0';
  }
}
