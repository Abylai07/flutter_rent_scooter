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
  String get next => 'Далее';

  @override
  String get start_ride => 'Начать поездку';

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

  @override
  String get onboadring_0_title => 'Добро пожаловать в Almaty Bike';

  @override
  String get onboadring_0_description_0 => 'Быстрый, удобный и экологичный способ передвижения!';

  @override
  String get onboadring_0_description_1 => 'Разблокируйте велосипед в пару кликов и наслаждайтесь поездкой';

  @override
  String get onboadring_0_description_2 => 'Соблюдайте правила безопасности и ПДД';

  @override
  String get onboadring_1_title => 'Как начать поездку?';

  @override
  String get onboadring_1_description_0 => 'Найдите ближайший электробайк на карте';

  @override
  String get onboadring_1_description_1 => 'Отсканируйте QR-код для разблокировки';

  @override
  String get onboadring_1_description_2 => 'Наслаждайтесь поездкой и соблюдайте правила';

  @override
  String get onboadring_1_description_3 => 'Завершите аренду, припарковав велосипед в разрешённом месте';

  @override
  String get onboadring_2_title => 'Основные правила дорожного движения';

  @override
  String get onboadring_2_description_0 => 'Держитесь правой стороны дороги';

  @override
  String get onboadring_2_description_1 => 'Уступайте пешеходам на переходах';

  @override
  String get onboadring_2_description_2 => 'Не ездите по тротуарам';

  @override
  String get onboadring_2_description_3 => 'Не пользуйтесь телефоном во время движения';

  @override
  String get onboadring_3_title => 'Завершение аренды и штрафы';

  @override
  String get onboadring_3_description_0 => 'Паркуйтесь в разрешённых зонах';

  @override
  String get onboadring_3_description_1 => 'Не блокируйте пешеходные дорожки';

  @override
  String get onboadring_3_description_2 => 'Оставленный в неположенном месте велосипед → штраф';

  @override
  String get onboadring_3_description_3 => 'Повреждение велосипеда → штраф';

  @override
  String get incorrect_phone => 'Неверный номер';

  @override
  String get incorrect_code => 'Неверный код';

  @override
  String get enter_code_from_sms => 'Введите код из SMS';

  @override
  String get authorization => 'Авторизация';
}
