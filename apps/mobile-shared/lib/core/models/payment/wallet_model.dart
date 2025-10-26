import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    required int id,
    required int userId,
    required double balance,
    required String currency,
    @Default([]) List<PaymentMethodModel> paymentMethods,
    @Default([]) List<TransactionModel> recentTransactions,
    double? bonusBalance,
    int? loyaltyPoints,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

@freezed
class PaymentMethodModel with _$PaymentMethodModel {
  const factory PaymentMethodModel({
    required int id,
    required PaymentMethodType type,
    required String displayName,
    required bool isDefault,
    String? last4Digits,
    String? expiryDate,
    String? cardBrand,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required int id,
    required TransactionType type,
    required double amount,
    required String currency,
    required TransactionStatus status,
    required String createdAt,
    String? description,
    int? rideSessionId,
    String? paymentMethodId,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

enum PaymentMethodType {
  @JsonValue('card')
  card,
  @JsonValue('apple_pay')
  applePay,
  @JsonValue('google_pay')
  googlePay,
  @JsonValue('wallet_balance')
  walletBalance,
}

enum TransactionType {
  @JsonValue('ride_payment')
  ridePayment,
  @JsonValue('top_up')
  topUp,
  @JsonValue('refund')
  refund,
  @JsonValue('bonus')
  bonus,
  @JsonValue('penalty')
  penalty,
}

enum TransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}
