import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morrf/models/order/morrf_order.dart';

import 'morrf_trainer.dart';

class MorrfUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  bool isOnline;
  String? gender;
  String? phoneNumber;
  Timestamp? birthday;
  String photoURL;
  String stripe;
  List<MorrfOrder>? orders;
  List<String?> favorites;
  String? aboutMe;
  MorrfTrainer? morrfTrainer;

  MorrfUser(
      {required this.id,
      required this.firstName,
      this.lastName = "",
      required this.fullName,
      required this.email,
      this.gender,
      this.phoneNumber,
      this.birthday,
      required this.isOnline,
      this.photoURL =
          "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*mvlre7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODAyMDYyNC41My4xLjE2OTgwMjE0MTEuNTcuMC4w",
      this.stripe = "",
      this.orders,
      required this.favorites,
      this.aboutMe,
      this.morrfTrainer});

  MorrfUser.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        fullName = data['fullName'],
        email = data['email'],
        isOnline = data['isOnline'],
        gender = data['gender'],
        phoneNumber = data['phoneNumber'],
        birthday = data['birthday'],
        photoURL = data['photoURL'],
        stripe = data['stripe'],
        favorites = List<String?>.from(data['favorites']),
        orders = List<MorrfOrder>.from(data['orders']),
        aboutMe = data['aboutMe'],
        morrfTrainer = data['morrfTrainer'] != null
            ? MorrfTrainer.fromMap(data['morrfTrainer'])
            : null;

  MorrfUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    bool? isOnline,
    String? gender,
    String? phoneNumber,
    Timestamp? birthday,
    String? photoURL,
    String? stripe,
    List<String?>? favorites,
    List<MorrfOrder>? orders,
    String? aboutMe,
    MorrfTrainer? morrfTrainer,
  }) {
    return MorrfUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      photoURL: photoURL ?? this.photoURL,
      stripe: stripe ?? this.stripe,
      favorites: favorites ?? this.favorites,
      orders: orders ?? this.orders,
      aboutMe: aboutMe ?? this.aboutMe,
      morrfTrainer: morrfTrainer ?? this.morrfTrainer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'isOnline': isOnline,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'photoURL': photoURL,
      'stripe': stripe,
      'favorites': favorites,
      'orders': orders,
      'aboutMe': aboutMe
    };
  }
}
