import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/service/auth_service.dart';
import 'package:morrf/models/user/morrf_user.dart';

final userProvider = StateProvider<MorrfUser?>((ref) => null);

final authControllerProvider = StateNotifierProvider<MorrfUserNotifier, bool>(
  (ref) => MorrfUserNotifier(
    authService: ref.watch(authServiceProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class MorrfUserNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  MorrfUserNotifier({required AuthService authService, required Ref ref})
      : _authService = authService,
        super(false);

  Future _init() async {
    state = false;
  }

  Stream<User?> get authStateChange => _authService.authStateChange;

  Stream<MorrfUser> getUserData(String uid) {
    return _authService.getUserData(uid);
  }

  void signupWithEmailAndPassword(
      BuildContext context, String email, String password) {
    _authService.signupWithEmailAndPassword(context, email, password);
  }

  void signinWithEmailAndPassword(
      BuildContext context, String email, String password) {
    _authService.signinWithEmailAndPassword(context, email, password);
  }

  void saveUserDataToFirebase(BuildContext context, User user, String email) {
    _authService.saveUserDataToFirebase(
      email: email,
      context: context,
    );
  }

  void setUserState(bool isOnline) {
    _authService.setUserState(isOnline);
  }

  void becomeTrainer() async {
    _authService.becomeTrainer();
  }

  void signout() {
    setUserState(false);
    print("signed out");
    _authService.signout();
  }
}
