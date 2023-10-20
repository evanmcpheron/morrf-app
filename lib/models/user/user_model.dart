import 'package:morrf/models/stripe/stripe_model.dart';

class MorrfUser {
  final String id;
  final String fullName;
  final String email;
  String? gender;
  DateTime? birthday;
  String? photoURL;
  StripeModel? stripe;
  // List<ProductModel>? products;

  MorrfUser(
      {required this.id,
      required this.fullName,
      required this.email,
      this.gender,
      this.birthday,
      this.photoURL,
      this.stripe});

  MorrfUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        gender = data['gender'],
        birthday = data['birthday'],
        photoURL = data['photoURL'],
        stripe = data['stripe'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'imageUrl': photoURL,
      'stripe': stripe
    };
  }
}
