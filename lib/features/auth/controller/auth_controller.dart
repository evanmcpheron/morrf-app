import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/repository/auth_repository.dart';
import 'package:morrf/models/user/morrf_user.dart';

final userProvider = StateProvider<MorrfUser?>((ref) => null);

final authControllerProvider = StateNotifierProvider<MorrfUserNotifier, bool>(
  (ref) => MorrfUserNotifier(
    authRepository: ref.watch(authRepositoryProvider),
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
  final AuthRepository _authRepository;
  MorrfUserNotifier({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        super(false);

  Future _init() async {
    state = false;
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<MorrfUser> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signupWithEmailAndPassword(
      BuildContext context, String email, String password) {
    _authRepository.signupWithEmailAndPassword(context, email, password);
  }

  void signinWithEmailAndPassword(
      BuildContext context, String email, String password) {
    _authRepository.signinWithEmailAndPassword(context, email, password);
  }

  void saveUserDataToFirebase(BuildContext context, User user, String email) {
    _authRepository.saveUserDataToFirebase(
      email: email,
      context: context,
    );
  }

  void setUserState(bool isOnline) {
    _authRepository.setUserState(isOnline);
  }

  void becomeTrainer() async {
    _authRepository.becomeTrainer();
  }

  void signout() {
    setUserState(false);
    _authRepository.signout();
  }
}
