// user_account_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserAccountModel with _$UserAccountModel {
  const factory UserAccountModel({
    required UserModel user,
    required AccountModel account,
  }) = _UserAccountModel;

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uuid,
    required String phone,
    @JsonKey(name: 'phone_number') required PhoneNumberModel phoneNumber,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'full_name') required String fullName,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class PhoneNumberModel with _$PhoneNumberModel {
  const factory PhoneNumberModel({
    required String phone,
    @JsonKey(name: 'country_code') required String countryCode,
  }) = _PhoneNumberModel;

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberModelFromJson(json);
}

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String uuid,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
