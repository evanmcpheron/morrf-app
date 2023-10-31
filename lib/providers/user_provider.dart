import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:uuid/uuid.dart';

class MorrfUserNotifier extends StateNotifier<MorrfUser> {
  User? user = FirebaseAuth.instance.currentUser;

  Future _init() async {
    state = MorrfUser(
      id: Uuid().v4(),
      firstName: "Guest",
      fullName: "Guest",
      email: "guest@morrf.me",
      favorites: [],
    );
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    state = parseSnapshot(data);
  }

  Future<void> getUser() async {
    if (user != null) {
      var unformattedUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      MorrfUser morrfUser = parseSnapshot(unformattedUser.data()!);
      state = morrfUser;
    }
  }

  MorrfUser parseSnapshot(Map<String, dynamic> data) {
    MorrfUser morrfUser = MorrfUser.fromData(data);
    return morrfUser;
  }

  MorrfUserNotifier()
      : super(
          MorrfUser(
            id: Uuid().v4(),
            firstName: "Guest",
            fullName: "Guest",
            email: "guest@morrf.me",
            favorites: [],
          ),
        ) {
    _init();
  }
}

final morrfUserProvider = StateNotifierProvider<MorrfUserNotifier, MorrfUser>(
  (ref) => MorrfUserNotifier(),
);
