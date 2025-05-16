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

  /// Hint for entering phone number
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enter_phone_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// Next
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Start the ride
  ///
  /// In en, this message translates to:
  /// **'Start ride'**
  String get start_ride;

  /// No description provided for @get_code.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get get_code;

  /// Time until code can be resent
  ///
  /// In en, this message translates to:
  /// **'Resend code in 00:{seconds}'**
  String resend_code_in(int seconds);

  /// Number of new messages on the home screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}'**
  String pageHomeInboxCount(int count);

  /// No description provided for @onboadring_0_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Almaty Bike'**
  String get onboadring_0_title;

  /// No description provided for @onboadring_0_description_0.
  ///
  /// In en, this message translates to:
  /// **'A fast, convenient and eco-friendly way to get around!'**
  String get onboadring_0_description_0;

  /// No description provided for @onboadring_0_description_1.
  ///
  /// In en, this message translates to:
  /// **'Unlock a bike in a couple of clicks and enjoy your ride'**
  String get onboadring_0_description_1;

  /// No description provided for @onboadring_0_description_2.
  ///
  /// In en, this message translates to:
  /// **'Follow safety rules and traffic regulations'**
  String get onboadring_0_description_2;

  /// No description provided for @onboadring_1_title.
  ///
  /// In en, this message translates to:
  /// **'How to start your ride?'**
  String get onboadring_1_title;

  /// No description provided for @onboadring_1_description_0.
  ///
  /// In en, this message translates to:
  /// **'Find the nearest e-bike on the map'**
  String get onboadring_1_description_0;

  /// No description provided for @onboadring_1_description_1.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code to unlock'**
  String get onboadring_1_description_1;

  /// No description provided for @onboadring_1_description_2.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your ride and follow the rules'**
  String get onboadring_1_description_2;

  /// No description provided for @onboadring_1_description_3.
  ///
  /// In en, this message translates to:
  /// **'End the rental by parking the bike in an allowed area'**
  String get onboadring_1_description_3;

  /// No description provided for @onboadring_2_title.
  ///
  /// In en, this message translates to:
  /// **'Basic traffic rules'**
  String get onboadring_2_title;

  /// No description provided for @onboadring_2_description_0.
  ///
  /// In en, this message translates to:
  /// **'Keep to the right side of the road'**
  String get onboadring_2_description_0;

  /// No description provided for @onboadring_2_description_1.
  ///
  /// In en, this message translates to:
  /// **'Give way to pedestrians at crossings'**
  String get onboadring_2_description_1;

  /// No description provided for @onboadring_2_description_2.
  ///
  /// In en, this message translates to:
  /// **'Do not ride on sidewalks'**
  String get onboadring_2_description_2;

  /// No description provided for @onboadring_2_description_3.
  ///
  /// In en, this message translates to:
  /// **'Do not use your phone while riding'**
  String get onboadring_2_description_3;

  /// No description provided for @onboadring_3_title.
  ///
  /// In en, this message translates to:
  /// **'Ending the ride and penalties'**
  String get onboadring_3_title;

  /// No description provided for @onboadring_3_description_0.
  ///
  /// In en, this message translates to:
  /// **'Park only in designated areas'**
  String get onboadring_3_description_0;

  /// No description provided for @onboadring_3_description_1.
  ///
  /// In en, this message translates to:
  /// **'Do not block pedestrian paths'**
  String get onboadring_3_description_1;

  /// No description provided for @onboadring_3_description_2.
  ///
  /// In en, this message translates to:
  /// **'Leaving the bike in a wrong place → fine'**
  String get onboadring_3_description_2;

  /// No description provided for @onboadring_3_description_3.
  ///
  /// In en, this message translates to:
  /// **'Damaging the bike → fine'**
  String get onboadring_3_description_3;

  /// No description provided for @incorrect_phone.
  ///
  /// In en, this message translates to:
  /// **'Incorrect number'**
  String get incorrect_phone;

  /// No description provided for @incorrect_code.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code'**
  String get incorrect_code;

  /// No description provided for @enter_code_from_sms.
  ///
  /// In en, this message translates to:
  /// **'Enter the code from SMS'**
  String get enter_code_from_sms;

  /// No description provided for @authorization.
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
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
