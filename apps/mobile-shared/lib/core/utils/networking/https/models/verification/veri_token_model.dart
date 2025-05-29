import 'package:freezed_annotation/freezed_annotation.dart';

part 'veri_token_model.freezed.dart';
part 'veri_token_model.g.dart';

@freezed
class VeriTokenModel with _$VeriTokenModel {
  const factory VeriTokenModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'person_id') required String personId,
  }) = _VeriTokenModel;

  factory VeriTokenModel.fromJson(Map<String, dynamic> json) =>
      _$VeriTokenModelFromJson(json);
}
