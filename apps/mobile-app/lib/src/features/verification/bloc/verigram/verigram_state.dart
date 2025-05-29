
part of 'verigram_cubit.dart';


class VerificationState extends Equatable {
  const VerificationState({
    this.status = CubitStatus.initial,
    this.entity,
    this.isCitizen = true,
    this.isVerified = false,
    this.docResult,
    this.faceResult,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final VeriTokenModel? entity;
  final bool isCitizen;
  final bool isVerified;
  final DocResultModel? docResult;
  final FacePersonModel? faceResult;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    isCitizen,
    isVerified,
    faceResult,
    docResult,
    message,
    count,
    errorCode,
  ];

  VerificationState copyWith({
    VeriTokenModel? entity,
    CubitStatus? status,
    bool? isCitizen,
    bool? isVerified,
    String? message,
    DocResultModel? docResult,
    FacePersonModel? faceResult,
    int? count,
    int? errorCode,
  }) {
    return VerificationState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      docResult: docResult ?? this.docResult,
      faceResult: faceResult ?? this.faceResult,
      status: status ?? this.status,
      isCitizen: isCitizen ?? this.isCitizen,
      isVerified: isVerified ?? this.isVerified,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
