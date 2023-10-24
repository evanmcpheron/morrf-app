import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/utils/firestore_service.dart';

class AuthService extends ChangeNotifier {
  User? authenticatedUser = FirebaseAuth.instance.currentUser;
  MorrfUser? currentMorrfUser;
  late bool isSignedIn = authenticatedUser != null;

  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  void setIsSignedIn() {
    isSignedIn = currentMorrfUser != null;
    notifyListeners();
  }

  void getCurrentMorrfUser() {
    FirestoreService().getCurrentMorrfUser();
  }

  void setCurrentMorrfUser(MorrfUser? user) {
    currentMorrfUser = user;
    setIsSignedIn();
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    String displayName = "$firstName $lastName";
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User addedUser = FirebaseAuth.instance.currentUser!;
      await addedUser.updatePhotoURL(
          "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*mvlre7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODAyMDYyNC41My4xLjE2OTgwMjE0MTEuNTcuMC4w");
      await addedUser.updateDisplayName(displayName);

      createUser(addedUser, firstName, lastName);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future createUser(
    User user,
    String firstName,
    String lastName,
  ) async {
    String displayName = "$firstName $lastName";
    try {
      MorrfUser morrfUser = MorrfUser(
          id: user.uid,
          fullName: displayName,
          email: user.email!,
          gender: null,
          birthday: null,
          photoURL:
              "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*mvlre7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODAyMDYyNC41My4xLjE2OTgwMjE0MTEuNTcuMC4w",
          firstName: firstName,
          lastName: lastName,
          stripe: "",
          products: [],
          orders: [],
          aboutMe: null);
      FirestoreService().createUser(morrfUser);
      currentMorrfUser = morrfUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      currentMorrfUser = null;
      setIsSignedIn();
    } catch (e) {
      rethrow;
    }
  }
}
