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

  /// `{count, plural, zero{У вас нет новых сообщений} one{У вас 1 новое сообщение} other{У вас {count} новых сообщений}}`
  String pageHomeInboxCount(int count) {
    return Intl.plural(
      count,
      zero: 'У вас нет новых сообщений',
      one: 'У вас 1 новое сообщение',
      other: 'У вас $count новых сообщений',
      name: 'pageHomeInboxCount',
      desc: 'Количество новых сообщений на главном экране',
      args: [count],
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
