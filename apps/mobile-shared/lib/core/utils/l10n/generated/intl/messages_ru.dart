// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'У вас нет новых сообщений', one: 'У вас 1 новое сообщение', other: 'У вас ${count} новых сообщений')}";

  static String m1(seconds) => "Отправить код через 00:${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authorization": MessageLookupByLibrary.simpleMessage("Авторизация"),
    "biometricPrompt": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте отпечаток пальца (или лицо) для аутентификации",
    ),
    "enableFaceId": MessageLookupByLibrary.simpleMessage(
      "Разрешить использовать Face ID для быстрого входа в приложение?",
    ),
    "enableTouchId": MessageLookupByLibrary.simpleMessage(
      "Разрешить использовать Touch ID для быстрого входа в приложение?",
    ),
    "enterPasscode": MessageLookupByLibrary.simpleMessage(
      "Придумайте код доступа",
    ),
    "enter_code_from_sms": MessageLookupByLibrary.simpleMessage(
      "Введите код из SMS",
    ),
    "enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Произошла ошибка"),
    "forgotPasscode": MessageLookupByLibrary.simpleMessage(
      "Забыли код доступа?",
    ),
    "get_code": MessageLookupByLibrary.simpleMessage("Получить код"),
    "incorrect_code": MessageLookupByLibrary.simpleMessage("Неверный код"),
    "incorrect_phone": MessageLookupByLibrary.simpleMessage("Неверный номер"),
    "inputPasscode": MessageLookupByLibrary.simpleMessage(
      "Введите код доступа",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Русский"),
    "next": MessageLookupByLibrary.simpleMessage("Далее"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "onboadring_0_description_0": MessageLookupByLibrary.simpleMessage(
      "Быстрый, удобный и экологичный способ передвижения!",
    ),
    "onboadring_0_description_1": MessageLookupByLibrary.simpleMessage(
      "Разблокируйте велосипед в пару кликов и наслаждайтесь поездкой",
    ),
    "onboadring_0_description_2": MessageLookupByLibrary.simpleMessage(
      "Соблюдайте правила безопасности и ПДД",
    ),
    "onboadring_0_title": MessageLookupByLibrary.simpleMessage(
      "Добро пожаловать в Almaty Bike",
    ),
    "onboadring_1_description_0": MessageLookupByLibrary.simpleMessage(
      "Найдите ближайший электробайк на карте",
    ),
    "onboadring_1_description_1": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте QR-код для разблокировки",
    ),
    "onboadring_1_description_2": MessageLookupByLibrary.simpleMessage(
      "Наслаждайтесь поездкой и соблюдайте правила",
    ),
    "onboadring_1_description_3": MessageLookupByLibrary.simpleMessage(
      "Завершите аренду, припарковав велосипед в разрешённом месте",
    ),
    "onboadring_1_title": MessageLookupByLibrary.simpleMessage(
      "Как начать поездку?",
    ),
    "onboadring_2_description_0": MessageLookupByLibrary.simpleMessage(
      "Держитесь правой стороны дороги",
    ),
    "onboadring_2_description_1": MessageLookupByLibrary.simpleMessage(
      "Уступайте пешеходам на переходах",
    ),
    "onboadring_2_description_2": MessageLookupByLibrary.simpleMessage(
      "Не ездите по тротуарам",
    ),
    "onboadring_2_description_3": MessageLookupByLibrary.simpleMessage(
      "Не пользуйтесь телефоном во время движения",
    ),
    "onboadring_2_title": MessageLookupByLibrary.simpleMessage(
      "Основные правила дорожного движения",
    ),
    "onboadring_3_description_0": MessageLookupByLibrary.simpleMessage(
      "Паркуйтесь в разрешённых зонах",
    ),
    "onboadring_3_description_1": MessageLookupByLibrary.simpleMessage(
      "Не блокируйте пешеходные дорожки",
    ),
    "onboadring_3_description_2": MessageLookupByLibrary.simpleMessage(
      "Оставленный в неположенном месте велосипед → штраф",
    ),
    "onboadring_3_description_3": MessageLookupByLibrary.simpleMessage(
      "Повреждение велосипеда → штраф",
    ),
    "onboadring_3_title": MessageLookupByLibrary.simpleMessage(
      "Завершение аренды и штрафы",
    ),
    "pageHomeInboxCount": m0,
    "phone_number": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "rememberedCode": MessageLookupByLibrary.simpleMessage("Вспомнил код"),
    "repeatPasscode": MessageLookupByLibrary.simpleMessage(
      "Повторите код доступа",
    ),
    "resend_code_in": m1,
    "setPasscode": MessageLookupByLibrary.simpleMessage(
      "Установить код доступа",
    ),
    "setPasscodeTitle": MessageLookupByLibrary.simpleMessage(
      "Для использования Face ID/Touch ID необходимо установить код доступа. Желаете установить?",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Начать поездку"),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
  };
}
