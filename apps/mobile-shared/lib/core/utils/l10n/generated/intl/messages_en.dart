// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'You have no new messages', one: 'You have 1 new message', other: 'You have ${count} new messages')}";

  static String m1(seconds) => "Resend code in 00:${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authorization": MessageLookupByLibrary.simpleMessage("Authorization"),
    "biometricPrompt": MessageLookupByLibrary.simpleMessage(
      "Scan your fingerprint (or face) for authentication",
    ),
    "enableFaceId": MessageLookupByLibrary.simpleMessage(
      "Allow using Face ID for quick login?",
    ),
    "enableTouchId": MessageLookupByLibrary.simpleMessage(
      "Allow using Touch ID for quick login?",
    ),
    "enterPasscode": MessageLookupByLibrary.simpleMessage("Create a passcode"),
    "enter_code_from_sms": MessageLookupByLibrary.simpleMessage(
      "Enter the code from SMS",
    ),
    "enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
    ),
    "error": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "forgotPasscode": MessageLookupByLibrary.simpleMessage("Forgot passcode?"),
    "get_code": MessageLookupByLibrary.simpleMessage("Get code"),
    "incorrect_code": MessageLookupByLibrary.simpleMessage("Incorrect code"),
    "incorrect_phone": MessageLookupByLibrary.simpleMessage("Incorrect number"),
    "inputPasscode": MessageLookupByLibrary.simpleMessage("Enter passcode"),
    "language": MessageLookupByLibrary.simpleMessage("English"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "onboadring_0_description_0": MessageLookupByLibrary.simpleMessage(
      "A fast, convenient and eco-friendly way to get around!",
    ),
    "onboadring_0_description_1": MessageLookupByLibrary.simpleMessage(
      "Unlock a bike in a couple of clicks and enjoy your ride",
    ),
    "onboadring_0_description_2": MessageLookupByLibrary.simpleMessage(
      "Follow safety rules and traffic regulations",
    ),
    "onboadring_0_title": MessageLookupByLibrary.simpleMessage(
      "Welcome to Almaty Bike",
    ),
    "onboadring_1_description_0": MessageLookupByLibrary.simpleMessage(
      "Find the nearest e-bike on the map",
    ),
    "onboadring_1_description_1": MessageLookupByLibrary.simpleMessage(
      "Scan the QR code to unlock",
    ),
    "onboadring_1_description_2": MessageLookupByLibrary.simpleMessage(
      "Enjoy your ride and follow the rules",
    ),
    "onboadring_1_description_3": MessageLookupByLibrary.simpleMessage(
      "End the rental by parking the bike in an allowed area",
    ),
    "onboadring_1_title": MessageLookupByLibrary.simpleMessage(
      "How to start your ride?",
    ),
    "onboadring_2_description_0": MessageLookupByLibrary.simpleMessage(
      "Keep to the right side of the road",
    ),
    "onboadring_2_description_1": MessageLookupByLibrary.simpleMessage(
      "Give way to pedestrians at crossings",
    ),
    "onboadring_2_description_2": MessageLookupByLibrary.simpleMessage(
      "Do not ride on sidewalks",
    ),
    "onboadring_2_description_3": MessageLookupByLibrary.simpleMessage(
      "Do not use your phone while riding",
    ),
    "onboadring_2_title": MessageLookupByLibrary.simpleMessage(
      "Basic traffic rules",
    ),
    "onboadring_3_description_0": MessageLookupByLibrary.simpleMessage(
      "Park only in designated areas",
    ),
    "onboadring_3_description_1": MessageLookupByLibrary.simpleMessage(
      "Do not block pedestrian paths",
    ),
    "onboadring_3_description_2": MessageLookupByLibrary.simpleMessage(
      "Leaving the bike in a wrong place → fine",
    ),
    "onboadring_3_description_3": MessageLookupByLibrary.simpleMessage(
      "Damaging the bike → fine",
    ),
    "onboadring_3_title": MessageLookupByLibrary.simpleMessage(
      "Ending the ride and penalties",
    ),
    "pageHomeInboxCount": m0,
    "phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
    "rememberedCode": MessageLookupByLibrary.simpleMessage(
      "I remembered the code",
    ),
    "repeatPasscode": MessageLookupByLibrary.simpleMessage(
      "Repeat the passcode",
    ),
    "resend_code_in": m1,
    "setPasscode": MessageLookupByLibrary.simpleMessage("Set Passcode"),
    "setPasscodeTitle": MessageLookupByLibrary.simpleMessage(
      "To use Face ID/Touch ID, you need to set a passcode. Would you like to set one?",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Start ride"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
  };
}
