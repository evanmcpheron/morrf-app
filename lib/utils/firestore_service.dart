import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/user/user_model.dart';
import 'package:morrf/utils/auth_service.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(MorrfUser user) async {
    try {
      final _uid = user.id;

      final result = await FirebaseFunctions.instance
          .httpsCallable('createStripeCustomer')
          .call(<String, dynamic>{'name': user.fullName, 'email': user.email});

      await _usersCollectionReference.doc(_uid).set({
        'id': _uid,
        'fullName': user.fullName,
        'birthday': null,
        'gender': null,
        'imageUrl': null,
        'email': user.email.toLowerCase(),
        'userWish': [],
        'userCart': [],
        'stripe': result.data['payload'],
        'createdAt': Timestamp.now(),
      }).then((value) => print("User Added"));
    } catch (e) {
      rethrow;
    }
  }

  Future getCurrentMorrfUser() async {
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
          return;
        });
      } else {
        AuthService().setCurrentMorrfUser(null);
      }
    } catch (e) {
      rethrow;
    }
  }
}
