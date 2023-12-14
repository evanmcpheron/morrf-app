import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/services/firestore/firestore_service.dart';

class MorrfServiceNotifier extends StateNotifier<MorrfService?> {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  MorrfServiceNotifier() : super(null);

  Future<void> getServiceById(String trainerName) async {
    try {
      MorrfService services =
          await FirestoreService().getServiceById(trainerName);

      state = services;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  void reset() {
    state = null;
  }
}

final morrfServiceProvider =
    StateNotifierProvider<MorrfServiceNotifier, MorrfService?>((ref) {
  return MorrfServiceNotifier();
});
