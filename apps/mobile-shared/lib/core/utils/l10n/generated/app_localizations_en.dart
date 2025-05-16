import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get enter_phone_number => 'Enter your phone number';

  @override
  String get phone_number => 'Phone number';

  @override
  String get next => 'Next';

  @override
  String get start_ride => 'Start ride';

  @override
  String get get_code => 'Get code';

  @override
  String resend_code_in(int seconds) {
    return 'Resend code in 00:$seconds';
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

  @override
  String get onboadring_0_title => 'Welcome to Almaty Bike';

  @override
  String get onboadring_0_description_0 => 'A fast, convenient and eco-friendly way to get around!';

  @override
  String get onboadring_0_description_1 => 'Unlock a bike in a couple of clicks and enjoy your ride';

  @override
  String get onboadring_0_description_2 => 'Follow safety rules and traffic regulations';

  @override
  String get onboadring_1_title => 'How to start your ride?';

  @override
  String get onboadring_1_description_0 => 'Find the nearest e-bike on the map';

  @override
  String get onboadring_1_description_1 => 'Scan the QR code to unlock';

  @override
  String get onboadring_1_description_2 => 'Enjoy your ride and follow the rules';

  @override
  String get onboadring_1_description_3 => 'End the rental by parking the bike in an allowed area';

  @override
  String get onboadring_2_title => 'Basic traffic rules';

  @override
  String get onboadring_2_description_0 => 'Keep to the right side of the road';

  @override
  String get onboadring_2_description_1 => 'Give way to pedestrians at crossings';

  @override
  String get onboadring_2_description_2 => 'Do not ride on sidewalks';

  @override
  String get onboadring_2_description_3 => 'Do not use your phone while riding';

  @override
  String get onboadring_3_title => 'Ending the ride and penalties';

  @override
  String get onboadring_3_description_0 => 'Park only in designated areas';

  @override
  String get onboadring_3_description_1 => 'Do not block pedestrian paths';

  @override
  String get onboadring_3_description_2 => 'Leaving the bike in a wrong place → fine';

  @override
  String get onboadring_3_description_3 => 'Damaging the bike → fine';

  @override
  String get incorrect_phone => 'Incorrect number';

  @override
  String get incorrect_code => 'Incorrect code';

  @override
  String get enter_code_from_sms => 'Enter the code from SMS';

  @override
  String get authorization => 'Authorization';
}
