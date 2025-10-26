import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobility_hub_shared/core/models/payment/wallet_model.dart';
import 'package:mobility_hub_shared/core/models/ride/ride_session_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<LoadWalletRequested>(_onLoadWallet);
    on<ProcessRidePaymentRequested>(_onProcessRidePayment);
    on<TopUpWalletRequested>(_onTopUpWallet);
    on<AddPaymentMethodRequested>(_onAddPaymentMethod);
    on<SetDefaultPaymentMethodRequested>(_onSetDefaultPaymentMethod);
    on<RemovePaymentMethodRequested>(_onRemovePaymentMethod);
    on<ApplyPromoCodeRequested>(_onApplyPromoCode);
    on<LoadTransactionHistoryRequested>(_onLoadTransactionHistory);
  }

  Future<void> _onLoadWallet(
    LoadWalletRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final wallet = WalletModel(
        id: 1,
        userId: event.userId,
        balance: 25.50,
        currency: 'USD',
        bonusBalance: 5.0,
        loyaltyPoints: 150,
        paymentMethods: [
          const PaymentMethodModel(
            id: 1,
            type: PaymentMethodType.card,
            displayName: 'Visa ending in 4242',
            isDefault: true,
            last4Digits: '4242',
            expiryDate: '12/25',
            cardBrand: 'Visa',
          ),
          const PaymentMethodModel(
            id: 2,
            type: PaymentMethodType.applePay,
            displayName: 'Apple Pay',
            isDefault: false,
          ),
        ],
        recentTransactions: [
          const TransactionModel(
            id: 1,
            type: TransactionType.ridePayment,
            amount: 3.50,
            currency: 'USD',
            status: TransactionStatus.completed,
            createdAt: '2025-01-15T10:30:00Z',
            description: 'Ride payment',
            rideSessionId: 123,
          ),
          const TransactionModel(
            id: 2,
            type: TransactionType.topUp,
            amount: 20.00,
            currency: 'USD',
            status: TransactionStatus.completed,
            createdAt: '2025-01-14T15:20:00Z',
            description: 'Wallet top-up',
          ),
        ],
      );

      emit(PaymentLoaded(wallet: wallet));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onProcessRidePayment(
    ProcessRidePaymentRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    emit(PaymentProcessing(
      wallet: currentState.wallet,
      amount: event.amount,
    ));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final paymentMethod = event.paymentMethodId != null
          ? currentState.wallet.paymentMethods
              .firstWhere((pm) => pm.id == event.paymentMethodId)
          : currentState.wallet.paymentMethods
              .firstWhere((pm) => pm.isDefault);

      double finalAmount = event.amount;
      double? discount;

      if (event.useBonus && currentState.wallet.bonusBalance != null) {
        final bonusToUse = currentState.wallet.bonusBalance! < finalAmount
            ? currentState.wallet.bonusBalance!
            : finalAmount;
        finalAmount -= bonusToUse;
        discount = bonusToUse;
      }

      if (currentState.appliedPromoCode != null) {
        final promoDiscount = finalAmount * currentState.appliedPromoCode!.discountPercent / 100;
        finalAmount -= promoDiscount;
        discount = (discount ?? 0) + promoDiscount;
      }

      final newBalance = currentState.wallet.balance - finalAmount;

      if (newBalance < 0 && paymentMethod.type == PaymentMethodType.walletBalance) {
        emit(PaymentError(
          message: 'Insufficient balance',
          previousState: currentState,
        ));
        return;
      }

      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch,
        type: TransactionType.ridePayment,
        amount: event.amount,
        currency: currentState.wallet.currency,
        status: TransactionStatus.completed,
        createdAt: DateTime.now().toIso8601String(),
        description: 'Ride payment',
        rideSessionId: event.rideSessionId,
        paymentMethodId: paymentMethod.id.toString(),
      );

      final updatedWallet = currentState.wallet.copyWith(
        balance: paymentMethod.type == PaymentMethodType.walletBalance
            ? newBalance
            : currentState.wallet.balance,
        bonusBalance: event.useBonus ? 0.0 : currentState.wallet.bonusBalance,
        recentTransactions: [
          transaction,
          ...currentState.wallet.recentTransactions,
        ],
      );

      final loyaltyPoints = (event.amount * 10).toInt();

      emit(PaymentSuccess(
        wallet: updatedWallet,
        transaction: transaction,
        earnedLoyaltyPoints: loyaltyPoints,
        discount: discount,
      ));
    } catch (e) {
      emit(PaymentError(
        message: 'Payment failed: ${e.toString()}',
        previousState: currentState,
      ));
    }
  }

  Future<void> _onTopUpWallet(
    TopUpWalletRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded && state is! PaymentSuccess) return;

    final currentWallet = state is PaymentLoaded
        ? (state as PaymentLoaded).wallet
        : (state as PaymentSuccess).wallet;

    emit(PaymentProcessing(
      wallet: currentWallet,
      amount: event.amount,
    ));

    try {
      await Future.delayed(const Duration(seconds: 2));

      double bonus = 0.0;
      if (event.amount >= 50) {
        bonus = event.amount * 0.1;
      } else if (event.amount >= 20) {
        bonus = event.amount * 0.05;
      }

      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch,
        type: TransactionType.topUp,
        amount: event.amount,
        currency: currentWallet.currency,
        status: TransactionStatus.completed,
        createdAt: DateTime.now().toIso8601String(),
        description: 'Wallet top-up',
        paymentMethodId: event.paymentMethodId.toString(),
      );

      final updatedWallet = currentWallet.copyWith(
        balance: currentWallet.balance + event.amount,
        bonusBalance: (currentWallet.bonusBalance ?? 0) + bonus,
        recentTransactions: [
          transaction,
          ...currentWallet.recentTransactions,
        ],
      );

      emit(PaymentSuccess(
        wallet: updatedWallet,
        transaction: transaction,
        bonusReceived: bonus > 0 ? bonus : null,
      ));
    } catch (e) {
      emit(PaymentError(
        message: 'Top-up failed: ${e.toString()}',
        previousState: state is PaymentLoaded ? state as PaymentLoaded : null,
      ));
    }
  }

  Future<void> _onAddPaymentMethod(
    AddPaymentMethodRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    emit(PaymentLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final newMethod = PaymentMethodModel(
        id: currentState.wallet.paymentMethods.length + 1,
        type: event.type,
        displayName: event.displayName,
        isDefault: event.setAsDefault,
        last4Digits: event.last4Digits,
        expiryDate: event.expiryDate,
        cardBrand: event.cardBrand,
      );

      var methods = List<PaymentMethodModel>.from(
        currentState.wallet.paymentMethods,
      );

      if (event.setAsDefault) {
        methods = methods.map((m) => m.copyWith(isDefault: false)).toList();
      }

      methods.add(newMethod);

      final updatedWallet = currentState.wallet.copyWith(
        paymentMethods: methods,
      );

      emit(PaymentLoaded(wallet: updatedWallet));
    } catch (e) {
      emit(PaymentError(
        message: 'Failed to add payment method',
        previousState: currentState,
      ));
    }
  }

  Future<void> _onSetDefaultPaymentMethod(
    SetDefaultPaymentMethodRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    final updatedMethods = currentState.wallet.paymentMethods.map((method) {
      return method.copyWith(isDefault: method.id == event.paymentMethodId);
    }).toList();

    emit(PaymentLoaded(
      wallet: currentState.wallet.copyWith(paymentMethods: updatedMethods),
    ));
  }

  Future<void> _onRemovePaymentMethod(
    RemovePaymentMethodRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    final updatedMethods = currentState.wallet.paymentMethods
        .where((method) => method.id != event.paymentMethodId)
        .toList();

    emit(PaymentLoaded(
      wallet: currentState.wallet.copyWith(paymentMethods: updatedMethods),
    ));
  }

  Future<void> _onApplyPromoCode(
    ApplyPromoCodeRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    emit(PaymentLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final promoCode = PromoCode(
        code: event.code,
        discountPercent: 15.0,
        validUntil: DateTime.now().add(const Duration(days: 7)),
      );

      emit(currentState.copyWith(appliedPromoCode: promoCode));
    } catch (e) {
      emit(PaymentError(
        message: 'Invalid promo code',
        previousState: currentState,
      ));
    }
  }

  Future<void> _onLoadTransactionHistory(
    LoadTransactionHistoryRequested event,
    Emitter<PaymentState> emit,
  ) async {
    if (state is! PaymentLoaded) return;

    final currentState = state as PaymentLoaded;

    emit(PaymentLoading(previousState: currentState));

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      emit(currentState);
    } catch (e) {
      emit(PaymentError(
        message: 'Failed to load transactions',
        previousState: currentState,
      ));
    }
  }
}
