part of 'verification_cubit.dart';

enum VerificationStatus {
  initial,
  successDoc,
  successEgov,
  successFace,
  successMatch,
  errorDoc,
  errorEgov,
  errorFace,
  errorMatch,
  loading
}

extension VerificationStatusX on VerificationStatus {
  bool get isInitial => this == VerificationStatus.initial;

  bool get isSuccessDoc => this == VerificationStatus.successDoc;

  bool get isSuccessFace => this == VerificationStatus.successFace;

  bool get isSuccessMatch => this == VerificationStatus.successMatch;

  bool get isSuccesEgov => this == VerificationStatus.successEgov;

  bool get isErrorEgov => this == VerificationStatus.errorEgov;

  bool get isErrorDoc => this == VerificationStatus.errorDoc;

  bool get isErrorFace => this == VerificationStatus.errorFace;

  bool get isErrorMatch => this == VerificationStatus.errorMatch;

  bool get isLoading => this == VerificationStatus.loading;
}

class VerificationDataState extends Equatable {
  const VerificationDataState({
    this.status = VerificationStatus.initial,
    this.faceEntity,
    this.docEntity,
    this.matchResult,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final VerificationStatus status;
  final FacePersonModel? faceEntity;
  final DocPersonModel? docEntity;
  final bool? matchResult;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
        status,
        faceEntity,
        matchResult,
        message,
        count,
        errorCode,
      ];

  VerificationDataState copyWith({
    FacePersonModel? faceEntity,
    DocPersonModel? docEntity,
    VerificationStatus? status,
    bool? matchResult,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return VerificationDataState(
      errorCode: errorCode,
      docEntity: docEntity ?? this.docEntity,
      matchResult: matchResult ?? this.matchResult,
      faceEntity: faceEntity ?? this.faceEntity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
