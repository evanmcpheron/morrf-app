import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/auth/repository/user_repository.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:uuid/uuid.dart';

class UserController extends ChangeNotifier {
  final UserRepository userRepository;
  final ProviderRef ref;
  MorrfUser morrfUser = MorrfUser(
      id: const Uuid().v4(),
      firstName: "Guest",
      fullName: "Guest",
      email: "guest@morrf.me",
      favorites: [],
      isOnline: true);
  UserController({
    required this.userRepository,
    required this.ref,
  });

  Stream<MorrfUser> userDataById(String userId) {
    return userRepository.userData(userId);
  }
}
