// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a kk locale. All the
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
  String get localeName => 'kk';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'Жаңа хабарламалар жоқ', one: '1 жаңа хабарламаңыз бар', other: '${count} жаңа хабарламаңыз бар')}";

  static String m1(seconds) => "Кодты қайта жіберу: 00:${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authorization": MessageLookupByLibrary.simpleMessage("Авторизация"),
    "biometricPrompt": MessageLookupByLibrary.simpleMessage(
      "Аутентификация үшін саусақ ізіңізді (немесе бетіңізді) сканерлеңіз",
    ),
    "enableFaceId": MessageLookupByLibrary.simpleMessage(
      "Қосымшаны жылдам ашу үшін Face ID пайдалануға рұқсат ету?",
    ),
    "enableTouchId": MessageLookupByLibrary.simpleMessage(
      "Қосымшаны жылдам ашу үшін Touch ID пайдалануға рұқсат ету?",
    ),
    "enterPasscode": MessageLookupByLibrary.simpleMessage(
      "Құпия код ойлап табыңыз",
    ),
    "enter_code_from_sms": MessageLookupByLibrary.simpleMessage(
      "SMS арқылы келген кодты енгізіңіз",
    ),
    "enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "Телефон нөмірін енгізіңіз",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Қате пайда болды"),
    "forgotPasscode": MessageLookupByLibrary.simpleMessage(
      "Құпия кодты ұмыттыңыз ба?",
    ),
    "get_code": MessageLookupByLibrary.simpleMessage("Кодты алу"),
    "incorrect_code": MessageLookupByLibrary.simpleMessage("Код қате"),
    "incorrect_phone": MessageLookupByLibrary.simpleMessage(
      "Телефон нөмірі қате",
    ),
    "inputPasscode": MessageLookupByLibrary.simpleMessage(
      "Құпия кодты енгізіңіз",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Қазақ тілі"),
    "next": MessageLookupByLibrary.simpleMessage("Келесі"),
    "no": MessageLookupByLibrary.simpleMessage("Жоқ"),
    "onboadring_0_description_0": MessageLookupByLibrary.simpleMessage(
      "Жылдам, ыңғайлы және экологиялық қозғалыс тәсілі!",
    ),
    "onboadring_0_description_1": MessageLookupByLibrary.simpleMessage(
      "Велосипедті бірнеше басуда ашып, сапарыңыздан ләззат алыңыз",
    ),
    "onboadring_0_description_2": MessageLookupByLibrary.simpleMessage(
      "Қауіпсіздік ережелері мен ЖҚЕ сақтаңыз",
    ),
    "onboadring_0_title": MessageLookupByLibrary.simpleMessage(
      "Almaty Bike-қа қош келдіңіз",
    ),
    "onboadring_1_description_0": MessageLookupByLibrary.simpleMessage(
      "Картадан ең жақын электровелосипедті табыңыз",
    ),
    "onboadring_1_description_1": MessageLookupByLibrary.simpleMessage(
      "Ашу үшін QR-кодты сканерлеңіз",
    ),
    "onboadring_1_description_2": MessageLookupByLibrary.simpleMessage(
      "Сапарыңыздан ләззат алыңыз және ережелерді сақтаңыз",
    ),
    "onboadring_1_description_3": MessageLookupByLibrary.simpleMessage(
      "Жалға алуды рұқсат етілген жерде аяқтаңыз",
    ),
    "onboadring_1_title": MessageLookupByLibrary.simpleMessage(
      "Жол жүруді қалай бастауға болады?",
    ),
    "onboadring_2_description_0": MessageLookupByLibrary.simpleMessage(
      "Жолдың оң жағымен жүріңіз",
    ),
    "onboadring_2_description_1": MessageLookupByLibrary.simpleMessage(
      "Өтпе жолдарда жаяу жүргіншілерге жол беріңіз",
    ),
    "onboadring_2_description_2": MessageLookupByLibrary.simpleMessage(
      "Тротуармен жүрмеңіз",
    ),
    "onboadring_2_description_3": MessageLookupByLibrary.simpleMessage(
      "Қозғалыс кезінде телефон қолданбаңыз",
    ),
    "onboadring_2_title": MessageLookupByLibrary.simpleMessage(
      "Негізгі жол қозғалысы ережелері",
    ),
    "onboadring_3_description_0": MessageLookupByLibrary.simpleMessage(
      "Рұқсат етілген аймақтарда тоқтаңыз",
    ),
    "onboadring_3_description_1": MessageLookupByLibrary.simpleMessage(
      "Жаяу жүргінші жолдарын жаппаңыз",
    ),
    "onboadring_3_description_2": MessageLookupByLibrary.simpleMessage(
      "Велосипедті рұқсат етілмеген жерде қалдыру → айыппұл",
    ),
    "onboadring_3_description_3": MessageLookupByLibrary.simpleMessage(
      "Велосипедке зақым келтіру → айыппұл",
    ),
    "onboadring_3_title": MessageLookupByLibrary.simpleMessage(
      "Жалға алуды аяқтау және айыппұлдар",
    ),
    "pageHomeInboxCount": m0,
    "phone_number": MessageLookupByLibrary.simpleMessage("Телефон нөмірі"),
    "rememberedCode": MessageLookupByLibrary.simpleMessage(
      "Құпия код есіме түсті",
    ),
    "repeatPasscode": MessageLookupByLibrary.simpleMessage(
      "Құпия кодты қайталаңыз",
    ),
    "resend_code_in": m1,
    "setPasscode": MessageLookupByLibrary.simpleMessage("Құпия код орнату"),
    "setPasscodeTitle": MessageLookupByLibrary.simpleMessage(
      "Face ID/Touch ID қолдану үшін құпия код орнату қажет. Құпия код орнатқыңыз келе ме?",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Жол жүруді бастау"),
    "yes": MessageLookupByLibrary.simpleMessage("Иә"),
  };
}
