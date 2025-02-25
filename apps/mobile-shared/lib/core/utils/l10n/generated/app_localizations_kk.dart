// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get language => 'Қазақ тілі';

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
      other: 'Сізде $count жаңа хабар бар',
      one: 'Сізде 1 жаңа хабар бар',
      zero: 'Сізде жаңа хабар жоқ',
    );
    return '$_temp0';
  }
}
