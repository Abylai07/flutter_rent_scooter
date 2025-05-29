import 'package:almabike_shared/almabike_shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'verigram_state.dart';

class VerificationDataCubit extends Cubit<VerificationDataState> {
  VerificationDataCubit(this.restClient) : super(const VerificationDataState());
  final AuthRestClient restClient;

  void scanDocument(DocResultModel result) async {
    emit(state.copyWith(status: VerificationStatus.loading));

    final Map<String, dynamic> data = {
      'firstName': result.firstName,
      'lastName': result.lastName,
      'docNumber': result.docNumber,
      'middleName': result.middleName,
      'birthDate': result.birthDate,
      'gender': result.gender,
      'country': result.country,
      'nationality': result.nationality,
      'issueDate': result.issueDate,
      'docCode': result.docCode,
      'dueDate': result.dueDate,
      'mrz': result.mrz,
      'docType': result.docType,
      'docFacePicture': result.facePicture,
      'docOriginalImg': result.originalImage,
      'firstNameRus': result.firstNameRus,
      'lastNameRus': result.lastNameRus,
      'middleNameRus': result.middleNameRus,
      'optionalData': result.optionalData,
    };

    // String? userId = SharedPrefs().getId();
    //
    // final response = await useCase
    //     .scanDocument(PathMapParams(data: data, path: userId ?? ''));
    // emit(
    //   response.fold(
    //     (l) => state.copyWith(
    //       status: VerificationStatus.errorDoc,
    //       message: l.message,
    //     ),
    //     (r) => state.copyWith(
    //       status: VerificationStatus.successDoc,
    //       docEntity: r,
    //     ),
    //   ),
    // );
  }

  void scanEgovCode(String code) async {
    emit(state.copyWith(status: VerificationStatus.loading));

    // String? userId = SharedPrefs().getId();
    //
    // final response = await useCase.scanCode(PathMapParams(
    //     data: {'code': AppUtils.codeMaskFormatter.unmaskText(code)},
    //     path: userId ?? ''));
    //
    // emit(
    //   response.fold(
    //     (l) => state.copyWith(
    //       status: VerificationStatus.errorEgov,
    //       message: l.message,
    //     ),
    //     (r) => state.copyWith(
    //       status: VerificationStatus.successEgov,
    //       docEntity: r,
    //     ),
    //   ),
    // );
  }

  void scanFace(Map<dynamic, dynamic> result) async {
    emit(state.copyWith(status: VerificationStatus.loading));

    Map<String, dynamic> data = {
      'status': result['status'],
      'reason': result['reason'],
      'bestframe': result['bestframe'],
    };

    // String? userId = SharedPrefs().getId();
    //
    // final response =
    //     await useCase.scanFace(PathMapParams(data: data, path: userId ?? ''));
    // emit(
    //   response.fold(
    //     (l) => state.copyWith(
    //       status: VerificationStatus.errorFace,
    //       message: l.message,
    //     ),
    //     (r) => state.copyWith(
    //       status: VerificationStatus.successFace,
    //       faceEntity: r,
    //     ),
    //   ),
    // );
  }

  void matchResults(VeriTokenModel? entity) async {
    emit(state.copyWith(status: VerificationStatus.loading));

    // final response = await useCase.matchFaceAndDoc(
    //   VeriMatchParams(
    //       id: entity?.personId ?? '',
    //       docId: state.docEntity?.id ?? '',
    //       faceId: state.faceEntity?.id ?? '',
    //       accessToken: entity?.accessToken ?? ''),
    // );
    //
    // emit(
    //   response.fold(
    //     (l) => state.copyWith(
    //       status: VerificationStatus.errorMatch,
    //       message: l.message,
    //     ),
    //     (r) => state.copyWith(
    //       status: VerificationStatus.successMatch,
    //       matchResult: r,
    //     ),
    //   ),
    // );
  }

  void setInitToState() {
    emit(const VerificationDataState());
  }
}
