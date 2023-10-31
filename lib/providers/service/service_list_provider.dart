import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/services/firestore/firestore_billing/firestore_card.dart';
import 'package:morrf/services/firestore/firestore_service.dart';

class MorrfServiceNotifier extends StateNotifier<List<MorrfService>> {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  MorrfServiceNotifier() : super([]);

  Future<void> deleteService(String cardId) async {
    await FirestoreCardService().deleteCard(cardId);
    state = state.where((i) => i.id != cardId).toList();
  }

  Future<void> getServicesByTrainer(String trainerId) async {
    try {
      List<MorrfService> services =
          await FirestoreService().getServicesByTrainer(trainerId);

      state = services;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  Future<void> getAllServices() async {
    try {
      List<MorrfService> services = await FirestoreService().getAllServices();
      state = services;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}

final morrfServicesProvider =
    StateNotifierProvider<MorrfServiceNotifier, List<MorrfService>>((ref) {
  return MorrfServiceNotifier();
});
