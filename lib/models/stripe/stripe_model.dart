import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:morrf/models/stripe/card_model.dart';

import '../user/morrf_address_model.dart';

class StripeModel {
  final String id;
  List<MorrfBillingDetails>? addresses = [];

  StripeModel({required this.id, this.addresses});

  StripeModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        addresses = data['addresses'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'addresses': addresses};
  }
}