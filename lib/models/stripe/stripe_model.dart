import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:morrf/models/stripe/card_model.dart';

import '../user/morrf_address_model.dart';

class MorrfStripe {
  final String id;
  List<MorrfBillingDetails>? addresses = [];

  MorrfStripe({required this.id, this.addresses});

  MorrfStripe.fromData(Map<String, dynamic> data)
      : id = data['id'],
        addresses = data['addresses'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'addresses': addresses};
  }
}
