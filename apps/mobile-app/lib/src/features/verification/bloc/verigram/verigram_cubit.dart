import 'package:almabike_shared/almabike_shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verigram_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._client) : super(const VerificationState());
  final AuthRestClient _client;

  void fetchVeriToken({bool isInit = true}) async {
    if(isInit){
      emit(const VerificationState(status: CubitStatus.loading));
    }
    // String? userId = SharedPrefs().getId();
    //
    // final response = await useCase.getVeriToken(PathParams(userId ?? ''));
    // emit(
    //   response.fold(
    //         (l) => VerigramState(
    //       status: CubitStatus.error,
    //       message: l.message,
    //     ),
    //         (r) => VerigramState(
    //       status: CubitStatus.success,
    //       entity: r,
    //     ),
    //   ),
    // );
  }

  Future<void> checkVerification() async {
    emit(const VerificationState(status: CubitStatus.loading));

    // String? userId = SharedPrefs().getId();
    //
    // final response = await useCase.checkVerification(PathParams(userId ?? ''));
    // emit(
    //   response.fold(
    //         (l) => VerigramState(
    //       status: CubitStatus.error,
    //       message: l.message,
    //     ),
    //         (r) => VerigramState(
    //       status: CubitStatus.success,
    //       isVerified: r,
    //     ),
    //   ),
    // );
  }

  void selectCitizen(bool isCitizen){
    emit(state.copyWith(isCitizen: isCitizen));
  }

  void addDocResult(DocResultModel result){
    emit(state.copyWith(docResult: result));
  }
}
