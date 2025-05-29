// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Русский`
  String get language {
    return Intl.message(
      'Русский',
      name: 'language',
      desc: 'Название языка',
      args: [],
    );
  }

  /// `Введите номер телефона`
  String get enter_phone_number {
    return Intl.message(
      'Введите номер телефона',
      name: 'enter_phone_number',
      desc: 'Подсказка для ввода номера телефона',
      args: [],
    );
  }

  /// `Номер телефона`
  String get phone_number {
    return Intl.message(
      'Номер телефона',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message('Далее', name: 'next', desc: 'Далее', args: []);
  }

  /// `Начать поездку`
  String get start_ride {
    return Intl.message(
      'Начать поездку',
      name: 'start_ride',
      desc: 'Начать поездку',
      args: [],
    );
  }

  /// `Получить код`
  String get get_code {
    return Intl.message('Получить код', name: 'get_code', desc: '', args: []);
  }

  /// `Отправить код через 00:{seconds}`
  String resend_code_in(int seconds) {
    return Intl.message(
      'Отправить код через 00:$seconds',
      name: 'resend_code_in',
      desc: 'Время для повторной отправки кода',
      args: [seconds],
    );
  }

  /// `Добро пожаловать в Almaty Bike`
  String get onboadring_0_title {
    return Intl.message(
      'Добро пожаловать в Almaty Bike',
      name: 'onboadring_0_title',
      desc: '',
      args: [],
    );
  }

  /// `Быстрый, удобный и экологичный способ передвижения!`
  String get onboadring_0_description_0 {
    return Intl.message(
      'Быстрый, удобный и экологичный способ передвижения!',
      name: 'onboadring_0_description_0',
      desc: '',
      args: [],
    );
  }

  /// `Разблокируйте велосипед в пару кликов и наслаждайтесь поездкой`
  String get onboadring_0_description_1 {
    return Intl.message(
      'Разблокируйте велосипед в пару кликов и наслаждайтесь поездкой',
      name: 'onboadring_0_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Соблюдайте правила безопасности и ПДД`
  String get onboadring_0_description_2 {
    return Intl.message(
      'Соблюдайте правила безопасности и ПДД',
      name: 'onboadring_0_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Как начать поездку?`
  String get onboadring_1_title {
    return Intl.message(
      'Как начать поездку?',
      name: 'onboadring_1_title',
      desc: '',
      args: [],
    );
  }

  /// `Найдите ближайший электробайк на карте`
  String get onboadring_1_description_0 {
    return Intl.message(
      'Найдите ближайший электробайк на карте',
      name: 'onboadring_1_description_0',
      desc: '',
      args: [],
    );
  }

  /// `Отсканируйте QR-код для разблокировки`
  String get onboadring_1_description_1 {
    return Intl.message(
      'Отсканируйте QR-код для разблокировки',
      name: 'onboadring_1_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Наслаждайтесь поездкой и соблюдайте правила`
  String get onboadring_1_description_2 {
    return Intl.message(
      'Наслаждайтесь поездкой и соблюдайте правила',
      name: 'onboadring_1_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Завершите аренду, припарковав велосипед в разрешённом месте`
  String get onboadring_1_description_3 {
    return Intl.message(
      'Завершите аренду, припарковав велосипед в разрешённом месте',
      name: 'onboadring_1_description_3',
      desc: '',
      args: [],
    );
  }

  /// `Основные правила дорожного движения`
  String get onboadring_2_title {
    return Intl.message(
      'Основные правила дорожного движения',
      name: 'onboadring_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Держитесь правой стороны дороги`
  String get onboadring_2_description_0 {
    return Intl.message(
      'Держитесь правой стороны дороги',
      name: 'onboadring_2_description_0',
      desc: '',
      args: [],
    );
  }

  /// `Уступайте пешеходам на переходах`
  String get onboadring_2_description_1 {
    return Intl.message(
      'Уступайте пешеходам на переходах',
      name: 'onboadring_2_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Не ездите по тротуарам`
  String get onboadring_2_description_2 {
    return Intl.message(
      'Не ездите по тротуарам',
      name: 'onboadring_2_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Не пользуйтесь телефоном во время движения`
  String get onboadring_2_description_3 {
    return Intl.message(
      'Не пользуйтесь телефоном во время движения',
      name: 'onboadring_2_description_3',
      desc: '',
      args: [],
    );
  }

  /// `Завершение аренды и штрафы`
  String get onboadring_3_title {
    return Intl.message(
      'Завершение аренды и штрафы',
      name: 'onboadring_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Паркуйтесь в разрешённых зонах`
  String get onboadring_3_description_0 {
    return Intl.message(
      'Паркуйтесь в разрешённых зонах',
      name: 'onboadring_3_description_0',
      desc: '',
      args: [],
    );
  }

  /// `Не блокируйте пешеходные дорожки`
  String get onboadring_3_description_1 {
    return Intl.message(
      'Не блокируйте пешеходные дорожки',
      name: 'onboadring_3_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Оставленный в неположенном месте велосипед → штраф`
  String get onboadring_3_description_2 {
    return Intl.message(
      'Оставленный в неположенном месте велосипед → штраф',
      name: 'onboadring_3_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Повреждение велосипеда → штраф`
  String get onboadring_3_description_3 {
    return Intl.message(
      'Повреждение велосипеда → штраф',
      name: 'onboadring_3_description_3',
      desc: '',
      args: [],
    );
  }

  /// `Неверный номер`
  String get incorrect_phone {
    return Intl.message(
      'Неверный номер',
      name: 'incorrect_phone',
      desc: '',
      args: [],
    );
  }

  /// `Неверный код`
  String get incorrect_code {
    return Intl.message(
      'Неверный код',
      name: 'incorrect_code',
      desc: '',
      args: [],
    );
  }

  /// `Введите код из SMS`
  String get enter_code_from_sms {
    return Intl.message(
      'Введите код из SMS',
      name: 'enter_code_from_sms',
      desc: '',
      args: [],
    );
  }

  /// `Авторизация`
  String get authorization {
    return Intl.message(
      'Авторизация',
      name: 'authorization',
      desc: '',
      args: [],
    );
  }

  /// `Для использования Face ID/Touch ID необходимо установить код доступа. Желаете установить?`
  String get setPasscodeTitle {
    return Intl.message(
      'Для использования Face ID/Touch ID необходимо установить код доступа. Желаете установить?',
      name: 'setPasscodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Да`
  String get yes {
    return Intl.message('Да', name: 'yes', desc: '', args: []);
  }

  /// `Нет`
  String get no {
    return Intl.message('Нет', name: 'no', desc: '', args: []);
  }

  /// `Установить код доступа`
  String get setPasscode {
    return Intl.message(
      'Установить код доступа',
      name: 'setPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Придумайте код доступа`
  String get enterPasscode {
    return Intl.message(
      'Придумайте код доступа',
      name: 'enterPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Повторите код доступа`
  String get repeatPasscode {
    return Intl.message(
      'Повторите код доступа',
      name: 'repeatPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Разрешить использовать Touch ID для быстрого входа в приложение?`
  String get enableTouchId {
    return Intl.message(
      'Разрешить использовать Touch ID для быстрого входа в приложение?',
      name: 'enableTouchId',
      desc: '',
      args: [],
    );
  }

  /// `Разрешить использовать Face ID для быстрого входа в приложение?`
  String get enableFaceId {
    return Intl.message(
      'Разрешить использовать Face ID для быстрого входа в приложение?',
      name: 'enableFaceId',
      desc: '',
      args: [],
    );
  }

  /// `Введите код доступа`
  String get inputPasscode {
    return Intl.message(
      'Введите код доступа',
      name: 'inputPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Вспомнил код`
  String get rememberedCode {
    return Intl.message(
      'Вспомнил код',
      name: 'rememberedCode',
      desc: '',
      args: [],
    );
  }

  /// `Забыли код доступа?`
  String get forgotPasscode {
    return Intl.message(
      'Забыли код доступа?',
      name: 'forgotPasscode',
      desc: '',
      args: [],
    );
  }

  /// `Отсканируйте отпечаток пальца (или лицо) для аутентификации`
  String get biometricPrompt {
    return Intl.message(
      'Отсканируйте отпечаток пальца (или лицо) для аутентификации',
      name: 'biometricPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Произошла ошибка`
  String get error {
    return Intl.message('Произошла ошибка', name: 'error', desc: '', args: []);
  }

  /// `Профиль`
  String get profile {
    return Intl.message('Профиль', name: 'profile', desc: '', args: []);
  }

  /// `Ввести номер вручную`
  String get enter_number_manually {
    return Intl.message(
      'Ввести номер вручную',
      name: 'enter_number_manually',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер велосипеда`
  String get enter_bike_number {
    return Intl.message(
      'Введите номер велосипеда',
      name: 'enter_bike_number',
      desc: '',
      args: [],
    );
  }

  /// `Номер`
  String get number {
    return Intl.message('Номер', name: 'number', desc: '', args: []);
  }

  /// `Бронирование будет активно в течении 10 минут, по истечении этого времени бронь отменяется`
  String get booking_notice {
    return Intl.message(
      'Бронирование будет активно в течении 10 минут, по истечении этого времени бронь отменяется',
      name: 'booking_notice',
      desc: '',
      args: [],
    );
  }

  /// `Отменить`
  String get cancel {
    return Intl.message('Отменить', name: 'cancel', desc: '', args: []);
  }

  /// `Забронировать`
  String get book {
    return Intl.message('Забронировать', name: 'book', desc: '', args: []);
  }

  /// `Осмотрите транспорт на предмет заметных внешних повреждений. Если обнаружите что-то, лучше взять другой транспорт`
  String get inspect_transport {
    return Intl.message(
      'Осмотрите транспорт на предмет заметных внешних повреждений. Если обнаружите что-то, лучше взять другой транспорт',
      name: 'inspect_transport',
      desc: '',
      args: [],
    );
  }

  /// `Кошелек`
  String get wallet {
    return Intl.message('Кошелек', name: 'wallet', desc: '', args: []);
  }

  /// `Мой транспорт`
  String get my_transport {
    return Intl.message(
      'Мой транспорт',
      name: 'my_transport',
      desc: '',
      args: [],
    );
  }

  /// `История`
  String get history {
    return Intl.message('История', name: 'history', desc: '', args: []);
  }

  /// `Штрафы`
  String get fines {
    return Intl.message('Штрафы', name: 'fines', desc: '', args: []);
  }

  /// `Безопасность`
  String get security {
    return Intl.message('Безопасность', name: 'security', desc: '', args: []);
  }

  /// `Банковские карты`
  String get bank_cards {
    return Intl.message(
      'Банковские карты',
      name: 'bank_cards',
      desc: '',
      args: [],
    );
  }

  /// `Страховка`
  String get insurance {
    return Intl.message('Страховка', name: 'insurance', desc: '', args: []);
  }

  /// `Как взять в аренду`
  String get how_to_rent {
    return Intl.message(
      'Как взять в аренду',
      name: 'how_to_rent',
      desc: '',
      args: [],
    );
  }

  /// `Обучение`
  String get training {
    return Intl.message('Обучение', name: 'training', desc: '', args: []);
  }

  /// `Язык`
  String get languageTitle {
    return Intl.message('Язык', name: 'languageTitle', desc: '', args: []);
  }

  /// `Поддержка`
  String get support {
    return Intl.message('Поддержка', name: 'support', desc: '', args: []);
  }

  /// `Выйти`
  String get logout {
    return Intl.message('Выйти', name: 'logout', desc: '', args: []);
  }

  /// `Вы действительно хотите выйти из аккаунта?`
  String get logout_confirmation {
    return Intl.message(
      'Вы действительно хотите выйти из аккаунта?',
      name: 'logout_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel_short {
    return Intl.message('Отмена', name: 'cancel_short', desc: '', args: []);
  }

  /// `Верификация`
  String get verification {
    return Intl.message(
      'Верификация',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Шаг {step} из 3`
  String step_num_of_3(int step) {
    return Intl.message(
      'Шаг $step из 3',
      name: 'step_num_of_3',
      desc: '',
      args: [step],
    );
  }

  /// `Введите данные`
  String get enter_data {
    return Intl.message(
      'Введите данные',
      name: 'enter_data',
      desc: '',
      args: [],
    );
  }

  /// `Я не резидент РК`
  String get not_resident {
    return Intl.message(
      'Я не резидент РК',
      name: 'not_resident',
      desc: '',
      args: [],
    );
  }

  /// `Шестизначный код документа`
  String get six_digit_code {
    return Intl.message(
      'Шестизначный код документа',
      name: 'six_digit_code',
      desc: '',
      args: [],
    );
  }

  /// `В Kaspi.kz или eGov, перейдите в раздел 'Цифровые документы', выберите 'Удостоверение личности', затем нажмите 'Предъявить документ' или 'Открыть доступ'`
  String get instructions {
    return Intl.message(
      'В Kaspi.kz или eGov, перейдите в раздел \'Цифровые документы\', выберите \'Удостоверение личности\', затем нажмите \'Предъявить документ\' или \'Открыть доступ\'',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте ваши личные данные`
  String get check_personal_data {
    return Intl.message(
      'Проверьте ваши личные данные',
      name: 'check_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `ФИО`
  String get full_name {
    return Intl.message('ФИО', name: 'full_name', desc: '', args: []);
  }

  /// `ИИН`
  String get iin {
    return Intl.message('ИИН', name: 'iin', desc: '', args: []);
  }

  /// `Номер документа`
  String get document_number {
    return Intl.message(
      'Номер документа',
      name: 'document_number',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения`
  String get birth_date {
    return Intl.message(
      'Дата рождения',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Место рождения`
  String get birth_place {
    return Intl.message(
      'Место рождения',
      name: 'birth_place',
      desc: '',
      args: [],
    );
  }

  /// `Национальность`
  String get nationality {
    return Intl.message(
      'Национальность',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Орган выдачи`
  String get issuing_authority {
    return Intl.message(
      'Орган выдачи',
      name: 'issuing_authority',
      desc: '',
      args: [],
    );
  }

  /// `Дата выдачи - срок действия`
  String get issue_expiry_date {
    return Intl.message(
      'Дата выдачи - срок действия',
      name: 'issue_expiry_date',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердите вашу личность`
  String get confirm_identity {
    return Intl.message(
      'Подтвердите вашу личность',
      name: 'confirm_identity',
      desc: '',
      args: [],
    );
  }

  /// `Пройдите face контроль \nдля успешного завершения верификации`
  String get face_control_instruction {
    return Intl.message(
      'Пройдите face контроль \nдля успешного завершения верификации',
      name: 'face_control_instruction',
      desc: '',
      args: [],
    );
  }

  /// `На фоне не должно быть других людей и предметов закрывающих ваше лицо`
  String get no_objects_background {
    return Intl.message(
      'На фоне не должно быть других людей и предметов закрывающих ваше лицо',
      name: 'no_objects_background',
      desc: '',
      args: [],
    );
  }

  /// `Пройти`
  String get start_verification {
    return Intl.message(
      'Пройти',
      name: 'start_verification',
      desc: '',
      args: [],
    );
  }

  /// `Идет проверка, подождите`
  String get verification_in_progress {
    return Intl.message(
      'Идет проверка, подождите',
      name: 'verification_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Не закрывайте приложение и не блокируйте экран.\nСкорость проверки данных зависит от качества интернет связи`
  String get do_not_close {
    return Intl.message(
      'Не закрывайте приложение и не блокируйте экран.\nСкорость проверки данных зависит от качества интернет связи',
      name: 'do_not_close',
      desc: '',
      args: [],
    );
  }

  /// `Верификация пройдена успешно`
  String get verification_success {
    return Intl.message(
      'Верификация пройдена успешно',
      name: 'verification_success',
      desc: '',
      args: [],
    );
  }

  /// `Верификация не пройдена`
  String get verification_failed {
    return Intl.message(
      'Верификация не пройдена',
      name: 'verification_failed',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, повторите попытку. Убедитесь, что данные правильно внесены`
  String get retry_verification {
    return Intl.message(
      'Пожалуйста, повторите попытку. Убедитесь, что данные правильно внесены',
      name: 'retry_verification',
      desc: '',
      args: [],
    );
  }

  /// `Пройти заново`
  String get try_again {
    return Intl.message('Пройти заново', name: 'try_again', desc: '', args: []);
  }

  /// `Face контроль не пройден. Пожалуйста, повторите попытку`
  String get face_control_failed {
    return Intl.message(
      'Face контроль не пройден. Пожалуйста, повторите попытку',
      name: 'face_control_failed',
      desc: '',
      args: [],
    );
  }

  /// `Загрузите страницу паспорта`
  String get upload_passport {
    return Intl.message(
      'Загрузите страницу паспорта',
      name: 'upload_passport',
      desc: '',
      args: [],
    );
  }

  /// `Отсканируйте/добавьте паспорт`
  String get scan_or_upload {
    return Intl.message(
      'Отсканируйте/добавьте паспорт',
      name: 'scan_or_upload',
      desc: '',
      args: [],
    );
  }

  /// `Сделать фото`
  String get take_photo {
    return Intl.message('Сделать фото', name: 'take_photo', desc: '', args: []);
  }

  /// `Загрузить с телефона`
  String get upload_from_phone {
    return Intl.message(
      'Загрузить с телефона',
      name: 'upload_from_phone',
      desc: '',
      args: [],
    );
  }

  /// `Фотография должна быть четкой, не размытой, без солнечных бликов`
  String get photo_quality_requirement {
    return Intl.message(
      'Фотография должна быть четкой, не размытой, без солнечных бликов',
      name: 'photo_quality_requirement',
      desc: '',
      args: [],
    );
  }

  /// `Переснять`
  String get retake {
    return Intl.message('Переснять', name: 'retake', desc: '', args: []);
  }

  /// `Вход по Face ID`
  String get faceIdLogin {
    return Intl.message(
      'Вход по Face ID',
      name: 'faceIdLogin',
      desc: '',
      args: [],
    );
  }

  /// `Вход по Touch ID`
  String get touchIdLogin {
    return Intl.message(
      'Вход по Touch ID',
      name: 'touchIdLogin',
      desc: '',
      args: [],
    );
  }

  /// `Вход по коду доступа`
  String get passcodeLogin {
    return Intl.message(
      'Вход по коду доступа',
      name: 'passcodeLogin',
      desc: '',
      args: [],
    );
  }

  /// `Сменить код доступа`
  String get changePasscode {
    return Intl.message(
      'Сменить код доступа',
      name: 'changePasscode',
      desc: '',
      args: [],
    );
  }

  /// `Сменить номер телефона`
  String get changePhoneNumber {
    return Intl.message(
      'Сменить номер телефона',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Личная информация`
  String get personalInfo {
    return Intl.message(
      'Личная информация',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message('Сохранить', name: 'save', desc: '', args: []);
  }

  /// `Удалить аккаунт`
  String get deleteAccount {
    return Intl.message(
      'Удалить аккаунт',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Вы действительно хотите удалить аккаунт? Данные аккаунта удалятся безвозвратно.`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Вы действительно хотите удалить аккаунт? Данные аккаунта удалятся безвозвратно.',
      name: 'deleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get confirmDelete {
    return Intl.message('Удалить', name: 'confirmDelete', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
