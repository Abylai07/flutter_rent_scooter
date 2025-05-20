import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_storage.dart';
import '../../../core/utils/services/locale_auth_service.dart';

part 'pin_code_event.dart';
part 'pin_code_state.dart';

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  PinCodeBloc() : super(const PinCodeState()) {
    on<DigitEntered>(_onDigitEntered);
    on<DigitRemoved>(_onDigitRemoved);
    on<PinCompleted>(_onPinCompleted);
    on<PinError>(_onPinError);
    on<ResetPinEntry>(_onResetPinEntry);
  }

  void _onDigitEntered(DigitEntered event, Emitter<PinCodeState> emit) {
    if (state.enteredPin.length < state.pinLength) {
      final newPin = state.enteredPin + event.digit;
      emit(state.copyWith(
        enteredPin: newPin,
        isError: false,
      ));

      // Auto-check if pin is complete
      if (newPin.length == state.pinLength) {
        add(PinCompleted());
      }
    }
  }

  void _onDigitRemoved(DigitRemoved event, Emitter<PinCodeState> emit) {
    if (state.enteredPin.isNotEmpty) {
      emit(state.copyWith(
        enteredPin: state.enteredPin.substring(0, state.enteredPin.length - 1),
        isError: false,
      ));
    } else if (state.enteredPin.isEmpty && state.currentStep.isConfirmation) {
      emit(state.copyWith(
        enteredPin: '',
        isError: false,
        currentStep: PinEntryStep.initial
      ));
    }
  }

  Future<void> _onPinCompleted(PinCompleted event, Emitter<PinCodeState> emit) async {
    if (state.currentStep == PinEntryStep.initial) {
      // First entry completed, move to confirmation step
      emit(state.copyWith(
        firstPin: state.enteredPin,
        enteredPin: '',
        currentStep: PinEntryStep.confirmation,
      ));
    } else {
      // Confirmation step, check if pins match
      if (state.enteredPin == state.firstPin) {
        // Success! Save the pin and check for biometrics
       // emit(state.copyWith(isProcessing: true));

        emit(state.copyWith(isProcessing: false));
      } else {
        // Pins don't match, show error and reset confirmation
        emit(state.copyWith(
          isError: true,
        ));
      }
    }
  }

  void _onPinError(PinError event, Emitter<PinCodeState> emit) async {
    emit(state.copyWith(
      isError: true,
    ));
  }

  void _onResetPinEntry(ResetPinEntry event, Emitter<PinCodeState> emit) {
    emit(const PinCodeState());
  }
}
