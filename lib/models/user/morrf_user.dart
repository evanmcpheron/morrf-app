import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morrf/models/service/morrf_service.dart';

class MorrfUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  String? gender;
  String? phoneNumber;
  Timestamp? birthday;
  String photoURL;
  String stripe;
  List<MorrfService>? services;
  List<MorrfOrder>? orders;
  String? aboutMe;

  MorrfUser(
      {required this.id,
      required this.firstName,
      this.lastName = "",
      required this.fullName,
      required this.email,
      this.gender,
      this.phoneNumber,
      this.birthday,
      this.photoURL =
          "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*mvlre7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODAyMDYyNC41My4xLjE2OTgwMjE0MTEuNTcuMC4w",
      this.stripe = "",
      this.services,
      this.orders,
      this.aboutMe});

  MorrfUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        fullName = data['fullName'],
        email = data['email'],
        gender = data['gender'],
        phoneNumber = data['phoneNumber'],
        birthday = data['birthday'],
        photoURL = data['photoURL'],
        stripe = data['stripe'],
        services = List<MorrfService>.from(data['services']),
        orders = List<MorrfOrder>.from(data['orders']),
        aboutMe = data['aboutMe'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'photoURL': photoURL,
      'stripe': stripe,
      'orders': orders,
      'services': services,
      'aboutMe': aboutMe
    };
  }
}

class MorrfOrder {
  String title;

  MorrfOrder({required this.title});
}
