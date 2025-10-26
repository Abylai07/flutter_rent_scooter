part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {
  final PaymentLoaded? previousState;

  const PaymentLoading({this.previousState});

  @override
  List<Object?> get props => [previousState];
}

class PaymentLoaded extends PaymentState {
  final WalletModel wallet;
  final PromoCode? appliedPromoCode;

  const PaymentLoaded({
    required this.wallet,
    this.appliedPromoCode,
  });

  PaymentLoaded copyWith({
    WalletModel? wallet,
    PromoCode? appliedPromoCode,
  }) {
    return PaymentLoaded(
      wallet: wallet ?? this.wallet,
      appliedPromoCode: appliedPromoCode ?? this.appliedPromoCode,
    );
  }

  @override
  List<Object?> get props => [wallet, appliedPromoCode];
}

class PaymentProcessing extends PaymentState {
  final WalletModel wallet;
  final double amount;

  const PaymentProcessing({
    required this.wallet,
    required this.amount,
  });

  @override
  List<Object?> get props => [wallet, amount];
}

class PaymentSuccess extends PaymentState {
  final WalletModel wallet;
  final TransactionModel transaction;
  final int? earnedLoyaltyPoints;
  final double? discount;
  final double? bonusReceived;

  const PaymentSuccess({
    required this.wallet,
    required this.transaction,
    this.earnedLoyaltyPoints,
    this.discount,
    this.bonusReceived,
  });

  @override
  List<Object?> get props => [
        wallet,
        transaction,
        earnedLoyaltyPoints,
        discount,
        bonusReceived,
      ];
}

class PaymentError extends PaymentState {
  final String message;
  final PaymentLoaded? previousState;

  const PaymentError({
    required this.message,
    this.previousState,
  });

  @override
  List<Object?> get props => [message, previousState];
}

class PromoCode {
  final String code;
  final double discountPercent;
  final DateTime validUntil;

  PromoCode({
    required this.code,
    required this.discountPercent,
    required this.validUntil,
  });
}
