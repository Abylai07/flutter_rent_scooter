import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru')
  ];

  /// The name of language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// Подсказка для ввода номера телефона
  ///
  /// In en, this message translates to:
  /// **'Введите номер телефона'**
  String get enter_phone_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Номер телефона'**
  String get phone_number;

  /// Далее
  ///
  /// In en, this message translates to:
  /// **'Далее'**
  String get next;

  /// Начать поездку
  ///
  /// In en, this message translates to:
  /// **'Начать поездку'**
  String get start_ride;

  /// No description provided for @get_code.
  ///
  /// In en, this message translates to:
  /// **'Получить код'**
  String get get_code;

  /// Время для повторной отправки кода
  ///
  /// In en, this message translates to:
  /// **'Отправить код через 00:{seconds}'**
  String resend_code_in(int seconds);

  /// Количество новых сообщений на главном экране
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{У вас нет новых сообщений} one{У вас 1 новое сообщение} other{У вас {count} новых сообщений}}'**
  String pageHomeInboxCount(int count);

  /// No description provided for @onboadring_0_title.
  ///
  /// In en, this message translates to:
  /// **'Добро пожаловать в Almaty Bike'**
  String get onboadring_0_title;

  /// No description provided for @onboadring_0_description_0.
  ///
  /// In en, this message translates to:
  /// **'Быстрый, удобный и экологичный способ передвижения!'**
  String get onboadring_0_description_0;

  /// No description provided for @onboadring_0_description_1.
  ///
  /// In en, this message translates to:
  /// **'Разблокируйте велосипед в пару кликов и наслаждайтесь поездкой'**
  String get onboadring_0_description_1;

  /// No description provided for @onboadring_0_description_2.
  ///
  /// In en, this message translates to:
  /// **'Соблюдайте правила безопасности и ПДД'**
  String get onboadring_0_description_2;

  /// No description provided for @onboadring_1_title.
  ///
  /// In en, this message translates to:
  /// **'Как начать поездку?'**
  String get onboadring_1_title;

  /// No description provided for @onboadring_1_description_0.
  ///
  /// In en, this message translates to:
  /// **'Найдите ближайший электробайк на карте'**
  String get onboadring_1_description_0;

  /// No description provided for @onboadring_1_description_1.
  ///
  /// In en, this message translates to:
  /// **'Отсканируйте QR-код для разблокировки'**
  String get onboadring_1_description_1;

  /// No description provided for @onboadring_1_description_2.
  ///
  /// In en, this message translates to:
  /// **'Наслаждайтесь поездкой и соблюдайте правила'**
  String get onboadring_1_description_2;

  /// No description provided for @onboadring_1_description_3.
  ///
  /// In en, this message translates to:
  /// **'Завершите аренду, припарковав велосипед в разрешённом месте'**
  String get onboadring_1_description_3;

  /// No description provided for @onboadring_2_title.
  ///
  /// In en, this message translates to:
  /// **'Основные правила дорожного движения'**
  String get onboadring_2_title;

  /// No description provided for @onboadring_2_description_0.
  ///
  /// In en, this message translates to:
  /// **'Держитесь правой стороны дороги'**
  String get onboadring_2_description_0;

  /// No description provided for @onboadring_2_description_1.
  ///
  /// In en, this message translates to:
  /// **'Уступайте пешеходам на переходах'**
  String get onboadring_2_description_1;

  /// No description provided for @onboadring_2_description_2.
  ///
  /// In en, this message translates to:
  /// **'Не ездите по тротуарам'**
  String get onboadring_2_description_2;

  /// No description provided for @onboadring_2_description_3.
  ///
  /// In en, this message translates to:
  /// **'Не пользуйтесь телефоном во время движения'**
  String get onboadring_2_description_3;

  /// No description provided for @onboadring_3_title.
  ///
  /// In en, this message translates to:
  /// **'Завершение аренды и штрафы'**
  String get onboadring_3_title;

  /// No description provided for @onboadring_3_description_0.
  ///
  /// In en, this message translates to:
  /// **'Паркуйтесь в разрешённых зонах'**
  String get onboadring_3_description_0;

  /// No description provided for @onboadring_3_description_1.
  ///
  /// In en, this message translates to:
  /// **'Не блокируйте пешеходные дорожки'**
  String get onboadring_3_description_1;

  /// No description provided for @onboadring_3_description_2.
  ///
  /// In en, this message translates to:
  /// **'Оставленный в неположенном месте велосипед → штраф'**
  String get onboadring_3_description_2;

  /// No description provided for @onboadring_3_description_3.
  ///
  /// In en, this message translates to:
  /// **'Повреждение велосипеда → штраф'**
  String get onboadring_3_description_3;

  /// No description provided for @incorrect_phone.
  ///
  /// In en, this message translates to:
  /// **'Неверный номер'**
  String get incorrect_phone;

  /// No description provided for @incorrect_code.
  ///
  /// In en, this message translates to:
  /// **'Неверный код'**
  String get incorrect_code;

  /// No description provided for @enter_code_from_sms.
  ///
  /// In en, this message translates to:
  /// **'Введите код из SMS'**
  String get enter_code_from_sms;

  /// No description provided for @authorization.
  ///
  /// In en, this message translates to:
  /// **'Авторизация'**
  String get authorization;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'kk': return AppLocalizationsKk();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
