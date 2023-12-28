import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/constants/firebase_constants.dart';
import 'package:morrf/core/repositories/common_firebase_storage_repository.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/core/utils.dart';
import 'package:uuid/uuid.dart';

final authServiceProvider = Provider(
  (ref) => AuthService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthService({
    required this.auth,
    required this.firestore,
  });

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<MorrfUser> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    MorrfUser user = MorrfUser(
      id: const Uuid().v4(),
      displayName: "Guest",
      email: "guest@morrf.me",
      favorites: [],
      isOnline: true,
    );
    ;

    if (userData.data() != null) {
      user = MorrfUser.fromMap(userData.data()!);
    }
    return user;
  }

  void updateUserInFirebase({
    required MorrfUser morrfUser,
    required String displayName,
    required File? profilePic,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }
      if (displayName != null) {
        await auth.currentUser!.updateDisplayName(displayName);
      }

      var user = morrfUser.copyWith(
        displayName: displayName,
        photoURL: photoUrl,
        isOnline: true,
      );
      await firestore.collection('users').doc(uid).set(user.toJson());

      Get.back();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
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
          displayName: "",
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

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
    setUserState(true);
  }

  Stream<MorrfUser> getUserData(String? uid) {
    return _users.doc(uid).snapshots().map(
          (event) => uid != null
              ? MorrfUser.fromMap(event.data() as Map<String, dynamic>)
              : MorrfUser(
                  id: const Uuid().v4(),
                  displayName: "Guest",
                  email: "guest@morrf.me",
                  favorites: [],
                  isOnline: true,
                ),
        );
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
      });
      Get.offAll(() => RedirectSplashScreen());
      return;
    } catch (e) {
      rethrow;
    }
  }
}
