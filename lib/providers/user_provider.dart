import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorrfUserNotifier extends StateNotifier<MorrfUser?> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();

    state = MorrfUser(
      id: Uuid().v4(),
      firstName: "Guest",
      fullName: "Guest",
      email: "guest@morrf.me",
    );
  }

  MorrfUserNotifier()
      : super(
          MorrfUser(
            id: Uuid().v4(),
            firstName: "Guest",
            fullName: "Guest",
            email: "guest@morrf.me",
          ),
        ) {
    _init();
  }
}

final morrfUserProvider = StateNotifierProvider<MorrfUserNotifier, MorrfUser?>(
  (ref) => MorrfUserNotifier(),
);
