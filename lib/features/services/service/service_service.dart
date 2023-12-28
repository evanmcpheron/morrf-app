import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/firebase_constants.dart';
import 'package:morrf/models/service/morrf_service.dart';

final serviceServiceProvider = Provider(
  (ref) => ServiceService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ServiceService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ServiceService({
    required this.auth,
    required this.firestore,
  });

  CollectionReference get _service =>
      firestore.collection(FirebaseConstants.servicesCollection);

  Future createService(MorrfService service) async {
    print(service.toJson());
    try {
      // await _service.doc(service.id).set(service.toJson());
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);
}
