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

  static String m0(seconds) => "Отправить код через 00:${seconds}";

  static String m1(step) => "Шаг ${step} из 3";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authorization": MessageLookupByLibrary.simpleMessage("Авторизация"),
    "bank_cards": MessageLookupByLibrary.simpleMessage("Банковские карты"),
    "biometricPrompt": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте отпечаток пальца (или лицо) для аутентификации",
    ),
    "birth_date": MessageLookupByLibrary.simpleMessage("Дата рождения"),
    "birth_place": MessageLookupByLibrary.simpleMessage("Место рождения"),
    "book": MessageLookupByLibrary.simpleMessage("Забронировать"),
    "booking_notice": MessageLookupByLibrary.simpleMessage(
      "Бронирование будет активно в течении 10 минут, по истечении этого времени бронь отменяется",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
    "cancel_short": MessageLookupByLibrary.simpleMessage("Отмена"),
    "changePasscode": MessageLookupByLibrary.simpleMessage(
      "Сменить код доступа",
    ),
    "changePhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Сменить номер телефона",
    ),
    "check_personal_data": MessageLookupByLibrary.simpleMessage(
      "Проверьте ваши личные данные",
    ),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "confirm_identity": MessageLookupByLibrary.simpleMessage(
      "Подтвердите вашу личность",
    ),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
    "deleteAccountConfirmation": MessageLookupByLibrary.simpleMessage(
      "Вы действительно хотите удалить аккаунт? Данные аккаунта удалятся безвозвратно.",
    ),
    "do_not_close": MessageLookupByLibrary.simpleMessage(
      "Не закрывайте приложение и не блокируйте экран.\nСкорость проверки данных зависит от качества интернет связи",
    ),
    "document_number": MessageLookupByLibrary.simpleMessage("Номер документа"),
    "enableFaceId": MessageLookupByLibrary.simpleMessage(
      "Разрешить использовать Face ID для быстрого входа в приложение?",
    ),
    "enableTouchId": MessageLookupByLibrary.simpleMessage(
      "Разрешить использовать Touch ID для быстрого входа в приложение?",
    ),
    "enterPasscode": MessageLookupByLibrary.simpleMessage(
      "Придумайте код доступа",
    ),
    "enter_bike_number": MessageLookupByLibrary.simpleMessage(
      "Введите номер велосипеда",
    ),
    "enter_code_from_sms": MessageLookupByLibrary.simpleMessage(
      "Введите код из SMS",
    ),
    "enter_data": MessageLookupByLibrary.simpleMessage("Введите данные"),
    "enter_number_manually": MessageLookupByLibrary.simpleMessage(
      "Ввести номер вручную",
    ),
    "enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Произошла ошибка"),
    "faceIdLogin": MessageLookupByLibrary.simpleMessage("Вход по Face ID"),
    "face_control_failed": MessageLookupByLibrary.simpleMessage(
      "Face контроль не пройден. Пожалуйста, повторите попытку",
    ),
    "face_control_instruction": MessageLookupByLibrary.simpleMessage(
      "Пройдите face контроль \nдля успешного завершения верификации",
    ),
    "fines": MessageLookupByLibrary.simpleMessage("Штрафы"),
    "forgotPasscode": MessageLookupByLibrary.simpleMessage(
      "Забыли код доступа?",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("ФИО"),
    "get_code": MessageLookupByLibrary.simpleMessage("Получить код"),
    "history": MessageLookupByLibrary.simpleMessage("История"),
    "how_to_rent": MessageLookupByLibrary.simpleMessage("Как взять в аренду"),
    "iin": MessageLookupByLibrary.simpleMessage("ИИН"),
    "incorrect_code": MessageLookupByLibrary.simpleMessage("Неверный код"),
    "incorrect_phone": MessageLookupByLibrary.simpleMessage("Неверный номер"),
    "inputPasscode": MessageLookupByLibrary.simpleMessage(
      "Введите код доступа",
    ),
    "inspect_transport": MessageLookupByLibrary.simpleMessage(
      "Осмотрите транспорт на предмет заметных внешних повреждений. Если обнаружите что-то, лучше взять другой транспорт",
    ),
    "instructions": MessageLookupByLibrary.simpleMessage(
      "В Kaspi.kz или eGov, перейдите в раздел \'Цифровые документы\', выберите \'Удостоверение личности\', затем нажмите \'Предъявить документ\' или \'Открыть доступ\'",
    ),
    "insurance": MessageLookupByLibrary.simpleMessage("Страховка"),
    "issue_expiry_date": MessageLookupByLibrary.simpleMessage(
      "Дата выдачи - срок действия",
    ),
    "issuing_authority": MessageLookupByLibrary.simpleMessage("Орган выдачи"),
    "language": MessageLookupByLibrary.simpleMessage("Русский"),
    "languageTitle": MessageLookupByLibrary.simpleMessage("Язык"),
    "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "logout_confirmation": MessageLookupByLibrary.simpleMessage(
      "Вы действительно хотите выйти из аккаунта?",
    ),
    "my_transport": MessageLookupByLibrary.simpleMessage("Мой транспорт"),
    "nationality": MessageLookupByLibrary.simpleMessage("Национальность"),
    "next": MessageLookupByLibrary.simpleMessage("Далее"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "no_objects_background": MessageLookupByLibrary.simpleMessage(
      "На фоне не должно быть других людей и предметов закрывающих ваше лицо",
    ),
    "not_resident": MessageLookupByLibrary.simpleMessage("Я не резидент РК"),
    "number": MessageLookupByLibrary.simpleMessage("Номер"),
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
    "passcodeLogin": MessageLookupByLibrary.simpleMessage(
      "Вход по коду доступа",
    ),
    "personalInfo": MessageLookupByLibrary.simpleMessage("Личная информация"),
    "phone_number": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "photo_quality_requirement": MessageLookupByLibrary.simpleMessage(
      "Фотография должна быть четкой, не размытой, без солнечных бликов",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "rememberedCode": MessageLookupByLibrary.simpleMessage("Вспомнил код"),
    "repeatPasscode": MessageLookupByLibrary.simpleMessage(
      "Повторите код доступа",
    ),
    "resend_code_in": m0,
    "retake": MessageLookupByLibrary.simpleMessage("Переснять"),
    "retry_verification": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, повторите попытку. Убедитесь, что данные правильно внесены",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "scan_or_upload": MessageLookupByLibrary.simpleMessage(
      "Отсканируйте/добавьте паспорт",
    ),
    "security": MessageLookupByLibrary.simpleMessage("Безопасность"),
    "setPasscode": MessageLookupByLibrary.simpleMessage(
      "Установить код доступа",
    ),
    "setPasscodeTitle": MessageLookupByLibrary.simpleMessage(
      "Для использования Face ID/Touch ID необходимо установить код доступа. Желаете установить?",
    ),
    "six_digit_code": MessageLookupByLibrary.simpleMessage(
      "Шестизначный код документа",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Начать поездку"),
    "start_verification": MessageLookupByLibrary.simpleMessage("Пройти"),
    "step_num_of_3": m1,
    "support": MessageLookupByLibrary.simpleMessage("Поддержка"),
    "take_photo": MessageLookupByLibrary.simpleMessage("Сделать фото"),
    "touchIdLogin": MessageLookupByLibrary.simpleMessage("Вход по Touch ID"),
    "training": MessageLookupByLibrary.simpleMessage("Обучение"),
    "try_again": MessageLookupByLibrary.simpleMessage("Пройти заново"),
    "upload_from_phone": MessageLookupByLibrary.simpleMessage(
      "Загрузить с телефона",
    ),
    "upload_passport": MessageLookupByLibrary.simpleMessage(
      "Загрузите страницу паспорта",
    ),
    "verification": MessageLookupByLibrary.simpleMessage("Верификация"),
    "verification_failed": MessageLookupByLibrary.simpleMessage(
      "Верификация не пройдена",
    ),
    "verification_in_progress": MessageLookupByLibrary.simpleMessage(
      "Идет проверка, подождите",
    ),
    "verification_success": MessageLookupByLibrary.simpleMessage(
      "Верификация пройдена успешно",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Кошелек"),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
  };
}
