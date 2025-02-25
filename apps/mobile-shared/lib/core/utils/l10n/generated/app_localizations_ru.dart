// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Русский';

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
      other: 'У вас $count новых сообщений',
      one: 'У вас 1 новое сообщение',
      zero: 'У вас нет новых сообщений',
    );
    return '$_temp0';
  }
}
