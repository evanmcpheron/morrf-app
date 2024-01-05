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

  Future<List<MorrfService>> getServicesByTrainer(String trainerId) async {
    try {
      List<MorrfService> morrfServices = [];
      await _services
          .where("trainerId", isEqualTo: trainerId)
          .get()
          .then((QuerySnapshot doc) {
        for (var service in doc.docs) {
          morrfServices.add(
              MorrfService.fromMap(service.data() as Map<String, dynamic>));
        }
      });
      return morrfServices;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }

  // Stream<List<MorrfService>> getServicesByTrainer(String trainerId) {
  //   return _services
  //       .withConverter<MorrfService>(
  //         fromFirestore: (snapshot, options) {
  //           return MorrfService.fromMap(snapshot.data()!);
  //         },
  //         toFirestore: (value, options) {
  //           return value.toJson();
  //         },
  //       )
  //       .snapshots()
  //       .map(
  //         (query) => query.docs.map((snapshot) => snapshot.data()).toList(),
  //       );
  // }

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);
}
