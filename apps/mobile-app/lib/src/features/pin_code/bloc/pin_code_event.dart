part of 'pin_code_bloc.dart';

abstract class PinCodeEvent extends Equatable {
  const PinCodeEvent();

  @override
  List<Object?> get props => [];
}

class DigitEntered extends PinCodeEvent {
  final String digit;

  const DigitEntered(this.digit);

  @override
  List<Object?> get props => [digit];
}

class DigitRemoved extends PinCodeEvent {}

class PinCompleted extends PinCodeEvent {}

class PinError extends PinCodeEvent {}

class ResetPinEntry extends PinCodeEvent {}

