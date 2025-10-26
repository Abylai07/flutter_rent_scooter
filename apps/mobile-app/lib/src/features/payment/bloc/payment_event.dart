part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class LoadWalletRequested extends PaymentEvent {
  final int userId;

  const LoadWalletRequested({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ProcessRidePaymentRequested extends PaymentEvent {
  final int rideSessionId;
  final double amount;
  final int? paymentMethodId;
  final bool useBonus;

  const ProcessRidePaymentRequested({
    required this.rideSessionId,
    required this.amount,
    this.paymentMethodId,
    this.useBonus = false,
  });

  @override
  List<Object?> get props => [rideSessionId, amount, paymentMethodId, useBonus];
}

class TopUpWalletRequested extends PaymentEvent {
  final double amount;
  final int paymentMethodId;

  const TopUpWalletRequested({
    required this.amount,
    required this.paymentMethodId,
  });

  @override
  List<Object?> get props => [amount, paymentMethodId];
}

class AddPaymentMethodRequested extends PaymentEvent {
  final PaymentMethodType type;
  final String displayName;
  final bool setAsDefault;
  final String? last4Digits;
  final String? expiryDate;
  final String? cardBrand;

  const AddPaymentMethodRequested({
    required this.type,
    required this.displayName,
    this.setAsDefault = false,
    this.last4Digits,
    this.expiryDate,
    this.cardBrand,
  });

  @override
  List<Object?> get props => [
        type,
        displayName,
        setAsDefault,
        last4Digits,
        expiryDate,
        cardBrand,
      ];
}

class SetDefaultPaymentMethodRequested extends PaymentEvent {
  final int paymentMethodId;

  const SetDefaultPaymentMethodRequested({required this.paymentMethodId});

  @override
  List<Object?> get props => [paymentMethodId];
}

class RemovePaymentMethodRequested extends PaymentEvent {
  final int paymentMethodId;

  const RemovePaymentMethodRequested({required this.paymentMethodId});

  @override
  List<Object?> get props => [paymentMethodId];
}

class ApplyPromoCodeRequested extends PaymentEvent {
  final String code;

  const ApplyPromoCodeRequested({required this.code});

  @override
  List<Object?> get props => [code];
}

class LoadTransactionHistoryRequested extends PaymentEvent {
  const LoadTransactionHistoryRequested();
}
