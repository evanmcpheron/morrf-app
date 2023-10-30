
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/service/morrf_service.dart';

class FirestoreService {
  final CollectionReference _serviceCollectionReference =
      FirebaseFirestore.instance.collection("services");
  User? user = FirebaseAuth.instance.currentUser;

  Future createService(MorrfService service) async {
    try {
      await _serviceCollectionReference.doc(service.id).set(service.toJson());
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }

  Future<List<MorrfService?>> getServicesByTrainer(String trainerId) async {
    try {
      List<MorrfService> morrfServices = [];
      await _serviceCollectionReference
          .where("trainerId", isEqualTo: trainerId)
          .get()
          .then((QuerySnapshot doc) {
        for (var service in doc.docs) {
          morrfServices.add(
              MorrfService.fromData(service.data() as Map<String, dynamic>));
        }
      });
      return morrfServices;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }
}
