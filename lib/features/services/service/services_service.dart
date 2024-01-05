import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/firebase_constants.dart';
import 'package:morrf/models/service/morrf_service.dart';

final servicesServiceProvider = Provider(
  (ref) => ServicesService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ServicesService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ServicesService({
    required this.auth,
    required this.firestore,
  });

  CollectionReference get _services =>
      firestore.collection(FirebaseConstants.servicesCollection);

  Stream<List<MorrfService>> getServicesByTrainer(String trainerId) {
    return _services
        .withConverter<MorrfService>(
          fromFirestore: (snapshot, options) {
            return MorrfService.fromMap(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .snapshots()
        .map(
          (query) => query.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);
}
