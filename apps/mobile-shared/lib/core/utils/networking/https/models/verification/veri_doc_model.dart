import 'package:freezed_annotation/freezed_annotation.dart';

part 'veri_doc_model.freezed.dart';
part 'veri_doc_model.g.dart';

@freezed
class DocResultModel with _$DocResultModel {
  const factory DocResultModel({
    @JsonKey(name: 'mrz_first_name') String? firstName,
    @JsonKey(name: 'mrz_last_name') String? lastName,
    @JsonKey(name: 'mrz_middle_name') String? middleName,
    @JsonKey(name: 'mrz_doc_number') String? docNumber,
    @JsonKey(name: 'mrz_nationality') String? nationality,
    @JsonKey(name: 'mrz_gender') String? gender,
    @JsonKey(name: 'mrz_country') String? country,
    @JsonKey(name: 'mrz_birth_date') String? birthDate,
    @JsonKey(name: 'mrz_doc_code') String? docCode,
    @JsonKey(name: 'mrz_due_date') String? dueDate,
    @JsonKey(name: 'mrz_1') String? mrzLine1,
    @JsonKey(name: 'mrz_2') String? mrzLine2,
    @JsonKey(name: 'mrz_3') String? mrzLine3,
    String? mrz,
    @JsonKey(name: 'mrz_check_digit_1') String? checkDigit1,
    @JsonKey(name: 'mrz_check_digit_2') String? checkDigit2,
    @JsonKey(name: 'mrz_check_digit_3') String? checkDigit3,
    @JsonKey(name: 'mrz_check_digit_4') String? checkDigit4,
    @JsonKey(name: 'mrz_check_digit_5') String? checkDigit5,
    @JsonKey(name: 'mrz_optional_data') String? optionalData,
    @JsonKey(name: 'mrz_first_name_rus') String? firstNameRus,
    @JsonKey(name: 'mrz_last_name_rus') String? lastNameRus,
    @JsonKey(name: 'mrz_middle_name_rus') String? middleNameRus,
    @JsonKey(name: 'mrz_issue_date') String? issueDate,
    @JsonKey(name: 'doc_type') String? docType,
    @JsonKey(name: 'face_picture') String? facePicture,
    @JsonKey(name: 'original_image') String? originalImage,
  }) = _DocResultModel;

  factory DocResultModel.fromJson(Map<String, dynamic> json) =>
      _$DocResultModelFromJson(json);
}