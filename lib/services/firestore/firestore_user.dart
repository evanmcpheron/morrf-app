import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/services/auth_service.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(MorrfUser user) async {
    try {
      final uid = user.id;
      final result = await FirebaseFunctions.instance
          .httpsCallable('createStripeCustomer')
          .call(<String, dynamic>{
        'name': user.fullName,
        'email': user.email.toLowerCase()
      });
      await _usersCollectionReference.doc(uid).set({
        'id': uid,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'fullName': user.fullName,
        'birthday': null,
        'gender': null,
        'photoURL': user.photoURL,
        'email': user.email.toLowerCase(),
        'orders': user.orders,
        'userWish': [],
        'userCart': [],
        'stripe': result.data['payload'],
        'favorites': [],
        'morrfTrainer': null,
        'createdAt': Timestamp.now(),
      }).then((value) => print("User Added"));
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<MorrfUser?> getCurrentMorrfUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        await _usersCollectionReference
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          MorrfUser morrfUser = MorrfUser.fromData(data);
          AuthService().setCurrentMorrfUser(morrfUser);
          return morrfUser;
        });
      } else {
        AuthService().setCurrentMorrfUser(null);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
