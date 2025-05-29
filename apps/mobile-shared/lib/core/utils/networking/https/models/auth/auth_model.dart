import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthTokensModel with _$AuthTokensModel {
  const factory AuthTokensModel({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required List<PermissionModel> permissions,
  }) = _AuthTokensModel;

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);
}

@freezed
class PermissionModel with _$PermissionModel {
  const factory PermissionModel({
    required String name,
    required List<String> scopes,
  }) = _PermissionModel;

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);
}
