import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_person_model.freezed.dart';
part 'face_person_model.g.dart';

@freezed
class FacePersonModel with _$FacePersonModel {
  const factory FacePersonModel({
    required String id,
    required String status,
    @JsonKey(name: 'bestframe') required String bestFrame,
    String? reason,
  }) = _FacePersonModel;

  factory FacePersonModel.fromJson(Map<String, dynamic> json) =>
      _$FacePersonModelFromJson(json);
}

// veri_doc_model.dart
