import 'package:freezed_annotation/freezed_annotation.dart';

part 'doc_person_model.freezed.dart';
part 'doc_person_model.g.dart';

@freezed
class DocPersonModel with _$DocPersonModel {
  const factory DocPersonModel({
    required String id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? birthDate,
    String? iin,
    String? gender,
    String? idNumber,
    String? birthPlace,
    String? nationality,
    String? ethnicity,
    String? issuer,
    String? issueDate,
    String? dueDate,
    String? mrzDocNumber,
    String? mrzNationality,
    String? mrzGender,
    String? mrzCountry,
    String? mrzBirthDate,
    String? mrzDocCode,
    String? mrzDueDate,
    String? mrz1,
    String? mrz2,
    String? mrz3,
    String? mrz,
    String? mrzFirstName,
    String? mrzLastName,
    String? mrzCheckDigit1,
    String? mrzCheckDigit2,
    String? mrzCheckDigit3,
    String? mrzCheckDigit4,
    String? docType,
    String? docFacePicture,
    String? docSignaturePicture,
    String? docOriginalFrontImg,
    String? docOriginalBackImg,
    String? docOriginalImg,
  }) = _DocPersonModel;

  factory DocPersonModel.fromJson(Map<String, dynamic> json) =>
      _$DocPersonModelFromJson(json).copyWith(
        firstName: capitalizeEachWord(json['firstName'].toString()),
        lastName: capitalizeEachWord(json['lastName'].toString()),
        middleName: capitalizeEachWord(json['middleName'].toString()),
        birthPlace: capitalizeEachWord(json['birthPlace'].toString()),
        ethnicity: capitalizeEachWord(json['ethnicity'].toString()),
        issuer: capitalizeEachWord(json['issuer'].toString()),
      );
}

String? capitalizeEachWord(String? sentence) {
  if (sentence == null || sentence.isEmpty) return sentence;

  return sentence
      .split(' ')
      .map((word) => word == 'ҚР'
          ? word
          : (word[0].toUpperCase() + word.substring(1).toLowerCase()))
      .join(' ');
}
