import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/firebase_constants.dart';

final trainerServiceProvider = Provider(
  (ref) => TrainerService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class TrainerService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  TrainerService({
    required this.auth,
    required this.firestore,
  });

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);
}
