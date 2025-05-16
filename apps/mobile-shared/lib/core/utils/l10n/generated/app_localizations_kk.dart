import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get language => 'Қазақ тілі';

  @override
  String get enter_phone_number => 'Телефон нөмірін енгізіңіз';

  @override
  String get phone_number => 'Телефон нөмірі';

  @override
  String get next => 'Келесі';

  @override
  String get start_ride => 'Жол жүруді бастау';

  @override
  String get get_code => 'Кодты алу';

  @override
  String resend_code_in(int seconds) {
    return 'Кодты қайта жіберу: 00:$seconds';
  }

  @override
  String pageHomeInboxCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count жаңа хабарламаңыз бар',
      one: '1 жаңа хабарламаңыз бар',
      zero: 'Жаңа хабарламалар жоқ',
    );
    return '$_temp0';
  }

  @override
  String get onboadring_0_title => 'Almaty Bike-қа қош келдіңіз';

  @override
  String get onboadring_0_description_0 => 'Жылдам, ыңғайлы және экологиялық қозғалыс тәсілі!';

  @override
  String get onboadring_0_description_1 => 'Велосипедті бірнеше басуда ашып, сапарыңыздан ләззат алыңыз';

  @override
  String get onboadring_0_description_2 => 'Қауіпсіздік ережелері мен ЖҚЕ сақтаңыз';

  @override
  String get onboadring_1_title => 'Жол жүруді қалай бастауға болады?';

  @override
  String get onboadring_1_description_0 => 'Картадан ең жақын электровелосипедті табыңыз';

  @override
  String get onboadring_1_description_1 => 'Ашу үшін QR-кодты сканерлеңіз';

  @override
  String get onboadring_1_description_2 => 'Сапарыңыздан ләззат алыңыз және ережелерді сақтаңыз';

  @override
  String get onboadring_1_description_3 => 'Жалға алуды рұқсат етілген жерде аяқтаңыз';

  @override
  String get onboadring_2_title => 'Негізгі жол қозғалысы ережелері';

  @override
  String get onboadring_2_description_0 => 'Жолдың оң жағымен жүріңіз';

  @override
  String get onboadring_2_description_1 => 'Өтпе жолдарда жаяу жүргіншілерге жол беріңіз';

  @override
  String get onboadring_2_description_2 => 'Тротуармен жүрмеңіз';

  @override
  String get onboadring_2_description_3 => 'Қозғалыс кезінде телефон қолданбаңыз';

  @override
  String get onboadring_3_title => 'Жалға алуды аяқтау және айыппұлдар';

  @override
  String get onboadring_3_description_0 => 'Рұқсат етілген аймақтарда тоқтаңыз';

  @override
  String get onboadring_3_description_1 => 'Жаяу жүргінші жолдарын жаппаңыз';

  @override
  String get onboadring_3_description_2 => 'Велосипедті рұқсат етілмеген жерде қалдыру → айыппұл';

  @override
  String get onboadring_3_description_3 => 'Велосипедке зақым келтіру → айыппұл';

  @override
  String get incorrect_phone => 'Телефон нөмірі қате';

  @override
  String get incorrect_code => 'Код қате';

  @override
  String get enter_code_from_sms => 'SMS арқылы келген кодты енгізіңіз';

  @override
  String get authorization => 'Авторизация';
}
