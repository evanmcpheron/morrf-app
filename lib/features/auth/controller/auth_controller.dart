import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/repository/auth_repository.dart';
import 'package:morrf/models/user/morrf_user.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<MorrfUser?> getUserData() async {
    MorrfUser? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signupWithEmailAndPassword(
      BuildContext context, String email, String password) {
    authRepository.signupWithEmailAndPassword(context, email, password);
  }

  void signinWithEmailAndPassword(
      BuildContext context, String email, String password) {
    authRepository.signinWithEmailAndPassword(context, email, password);
  }

  void saveUserDataToFirebase(BuildContext context, User user, String email) {
    authRepository.saveUserDataToFirebase(
      email: email,
      context: context,
    );
  }

  Stream<MorrfUser> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }

  void signout() {
    setUserState(false);
    authRepository.signout();
  }
}
