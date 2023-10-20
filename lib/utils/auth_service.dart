import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morrf/models/user/user_model.dart';
import 'package:morrf/models/stripe/stripe_model.dart';
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
    String displayName,
  ) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User addedUser = FirebaseAuth.instance.currentUser!;

      await addedUser.updateDisplayName(displayName);

      createUser(addedUser, displayName);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future createUser(User user, String displayName) async {
    try {
      MorrfUser morrfUser = MorrfUser(
          id: user.uid,
          fullName: displayName,
          email: user.email!,
          gender: null,
          birthday: null,
          photoURL: null);
      FirestoreService().createUser(morrfUser);
      currentMorrfUser = morrfUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    print(email);
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
