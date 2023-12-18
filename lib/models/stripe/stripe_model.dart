import '../user/morrf_address_model.dart';

class MorrfStripe {
  final String id;
  List<MorrfBillingDetails>? addresses = [];

  MorrfStripe({required this.id, this.addresses});

  MorrfStripe.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        addresses = data['addresses'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'addresses': addresses};
  }
}
