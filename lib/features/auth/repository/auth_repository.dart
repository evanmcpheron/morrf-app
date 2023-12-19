import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/core/utils.dart';
import 'package:uuid/uuid.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<MorrfUser?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    MorrfUser? user;

    if (userData.data() != null) {
      user = MorrfUser.fromMap(userData.data()!);
    }
    return user;
  }

  void signupWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveUserDataToFirebase(context: context, email: email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void signinWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAll(() => RedirectSplashScreen());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String email,
    required BuildContext context,
  }) async {
    try {
      User currentUser = auth.currentUser!;
      String uid = currentUser.uid;
      String photoUrl =
          'https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*mvlre7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODAyMDYyNC41My4xLjE2OTgwMjE0MTEuNTcuMC4w';

      await currentUser.updatePhotoURL(photoUrl);

      var user = MorrfUser(
          firstName: "",
          lastName: "",
          fullName: "",
          email: email,
          isOnline: true,
          id: uid,
          favorites: [],
          orders: []);

      await firestore.collection('users').doc(uid).set(user.toJson());

      Get.offAll(() => RedirectSplashScreen());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Stream<MorrfUser> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => MorrfUser.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }

  void signout() async {
    await auth.signOut();
  }

  void becomeTrainer() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({
        'morrfTrainer': {
          'id': const Uuid().v4(),
          'services': [],
          'ratings': [],
          'orders': []
        }
      }).then((value) {
        Get.offAll(() => RedirectSplashScreen());
      });
    } catch (e) {
      rethrow;
    }
  }
}
