import 'package:morrf/models/user/morrf_address_model.dart';

class MorrfCreditCardModel {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final MorrfBillingDetails billingDetails;

  const MorrfCreditCardModel(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.billingDetails});
}

class MorrfPaymentMethod {
  String object;
  bool livemode;
  String id;
  MorrfBillingDetails billingDetails;
  CardInfo card;
  int created;
  String type;
  String customer;
  Map<String, dynamic> metadata;

  MorrfPaymentMethod({
    required this.object,
    required this.livemode,
    required this.id,
    required this.billingDetails,
    required this.card,
    required this.created,
    required this.type,
    required this.customer,
    required this.metadata,
  });

  factory MorrfPaymentMethod.fromJson(Map<String, dynamic> json) {
    return MorrfPaymentMethod(
      object: json['object'],
      livemode: json['livemode'],
      id: json['id'],
      billingDetails: MorrfBillingDetails.fromJson(json['billing_details']),
      card: CardInfo.fromJson(json['card']),
      created: json['created'],
      type: json['type'],
      customer: json['customer'],
      metadata: json['metadata'],
    );
  }
}

class CardInfo {
  String fingerprint;
  String last4;
  String funding;
  String generatedFrom;
  String brand;
  int expMonth;
  int expYear;
  String country;

  CardInfo({
    required this.fingerprint,
    required this.last4,
    required this.funding,
    required this.generatedFrom,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.country,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      fingerprint: json['fingerprint'],
      last4: json['last4'],
      funding: json['funding'],
      generatedFrom: json['generated_from'],
      brand: json['brand'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      country: json['country'],
    );
  }
}
