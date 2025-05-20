part of 'pin_code_bloc.dart';

enum PinEntryStep { initial, confirmation }

extension PinEntryStepX on PinEntryStep {
  bool get isInitial => this == PinEntryStep.initial;

  bool get isConfirmation => this == PinEntryStep.confirmation;
}

class PinCodeState extends Equatable {
  final String enteredPin;
  final String firstPin;
  final int pinLength;
  final PinEntryStep currentStep;
  final bool isError;
  final bool isProcessing;

  const PinCodeState({
    this.enteredPin = '',
    this.firstPin = '',
    this.pinLength = 4,
    this.currentStep = PinEntryStep.initial,
    this.isError = false,
    this.isProcessing = false,
  });

  PinCodeState copyWith({
    String? enteredPin,
    String? firstPin,
    int? pinLength,
    PinEntryStep? currentStep,
    bool? isError,
    bool? isProcessing,
  }) {
    return PinCodeState(
      enteredPin: enteredPin ?? this.enteredPin,
      firstPin: firstPin ?? this.firstPin,
      pinLength: pinLength ?? this.pinLength,
      currentStep: currentStep ?? this.currentStep,
      isError: isError ?? this.isError,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  bool get isPinComplete => enteredPin.length == pinLength;

  @override
  List<Object?> get props => [
        enteredPin,
        firstPin,
        pinLength,
        currentStep,
        isError,
        isProcessing,
      ];
}
