// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:morrf/features/auth/repository/auth_repository.dart';
// import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
// import 'package:morrf/models/user/morrf_user.dart';

// final authControllerProvider = Provider((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthController(authRepository: authRepository, ref: ref);
// });

// final userDataAuthProvider = FutureProvider((ref) {
//   final authController = ref.watch(authControllerProvider);
//   print("Hite here");
//   return authController.getUserData();
// });

// class AuthController {
//   final AuthRepository authRepository;
//   final ProviderRef ref;
//   AuthController({
//     required this.authRepository,
//     required this.ref,
//   });

// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/repository/auth_repository.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:uuid/uuid.dart';

class MorrfUserNotifier extends StateNotifier<MorrfUser> {
  AuthRepository authRepository = AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
  Future _init() async {
    state = MorrfUser(
      id: const Uuid().v4(),
      firstName: "Guest",
      fullName: "Guest",
      email: "guest@morrf.me",
      favorites: [],
      isOnline: true,
    );
  }

  Future<MorrfUser> getUserData() async {
    MorrfUser user = await authRepository.getCurrentUserData();
    state = user;
    return user;
  }

  void signupWithEmailAndPassword(
      BuildContext context, String email, String password) {
    authRepository.signupWithEmailAndPassword(context, email, password);
  }

  void signinWithEmailAndPassword(
      BuildContext context, String email, String password) {
    authRepository.signinWithEmailAndPassword(context, email, password);
    setUserState(true);
  }

  void saveUserDataToFirebase(BuildContext context, User user, String email) {
    authRepository.saveUserDataToFirebase(
      email: email,
      context: context,
    );
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }

  void becomeTrainer() async {
    authRepository.becomeTrainer();
    MorrfUser? user = await getUserData();
    state = user!;
  }

  void signout() {
    setUserState(false);
    authRepository.signout();
  }

  MorrfUserNotifier()
      : super(
          MorrfUser(
              id: const Uuid().v4(),
              firstName: "Guest",
              fullName: "Guest",
              email: "guest@morrf.me",
              favorites: [],
              isOnline: true),
        ) {
    _init();
  }
}

final authControllerProvider =
    StateNotifierProvider<MorrfUserNotifier, MorrfUser>(
  (ref) => MorrfUserNotifier(),
);
