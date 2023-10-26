import 'package:morrf/models/user/morrf_address_model.dart';

// class MorrfPaymentMethod {
//   String object;
//   bool livemode;
//   String id;
//   MorrfBillingDetails billingDetails;
//   CardInfo card;
//   int created;
//   String type;
//   String customer;
//   Map<String, dynamic> metadata;

//   MorrfPaymentMethod({
//     required this.object,
//     required this.livemode,
//     required this.id,
//     required this.billingDetails,
//     required this.card,
//     required this.created,
//     required this.type,
//     required this.customer,
//     required this.metadata,
//   });

//   factory MorrfPaymentMethod.fromJson(Map<String, dynamic> json) {
//     return MorrfPaymentMethod(
//       object: json['object'],
//       livemode: json['livemode'],
//       id: json['id'],
//       billingDetails: MorrfBillingDetails.fromJson(json['billing_details']),
//       card: CardInfo.fromJson(json['card']),
//       created: json['created'],
//       type: json['type'],
//       customer: json['customer'],
//       metadata: json['metadata'],
//     );
//   }
// }

class MorrfCreditCard {
  String id;
  String userId;
  String last4;
  String funding;
  String? generatedFrom;
  String brand;
  int expMonth;
  int expYear;
  String country;
  bool isDefault;

  MorrfCreditCard(
      {required this.id,
      required this.userId,
      required this.last4,
      required this.funding,
      this.generatedFrom,
      required this.brand,
      required this.expMonth,
      required this.expYear,
      required this.country,
      this.isDefault = false});

  factory MorrfCreditCard.fromJson(Map<String, dynamic> json) {
    return MorrfCreditCard(
        id: json['id'],
        userId: json['userId'],
        last4: json['last4'],
        funding: json['funding'],
        generatedFrom: json['generated_from'],
        brand: json['brand'],
        expMonth: json['expMonth'],
        expYear: json['expYear'],
        country: json['country'],
        isDefault: json['isDefault']);
  }
}
