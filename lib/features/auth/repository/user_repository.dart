import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/user/morrf_user.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class UserRepository {
  final FirebaseFirestore firestore;
  UserRepository({
    required this.firestore,
  });

  Stream<MorrfUser> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => MorrfUser.fromMap(
            event.data()!,
          ),
        );
  }
}
