import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:uuid/uuid.dart';

class MorrfUserNotifier extends StateNotifier<MorrfUser> {
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
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.displayName);
      var unformattedUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      print(unformattedUser.data()!['morrfTrainer']);
      MorrfUser morrfUser = parseSnapshot(unformattedUser.data()!);
      state = morrfUser;
    }
  }

  void signOut() {
    state = MorrfUser(
      id: Uuid().v4(),
      firstName: "Guest",
      fullName: "Guest",
      email: "guest@morrf.me",
      favorites: [],
    );
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
