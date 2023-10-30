import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/stripe/card_model.dart';
import 'package:morrf/services/firestore/firestore_billing/firestore_card.dart';

import 'loading_provider.dart';

class MorrfCreditCardsNotifier extends StateNotifier<List<MorrfCreditCard>> {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  MorrfCreditCardsNotifier() : super([]);

  Future<void> createCard(String paymentMethodId, LoadingNotifier ref) async {
    ref.startLoader();
    final card = await FirestoreCardService().createCard(paymentMethodId);
    ref.stopLoader();
    state = [card, ...state];
  }

  Future<void> updateDefaultCard(String cardId, LoadingNotifier ref) async {
    try {
      ref.startLoader();
      final cards = await FirestoreCardService().updateDefaultCard(cardId);
      state = cards;
      ref.stopLoader();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCard(String cardId) async {
    await FirestoreCardService().deleteCard(cardId);
    state = state.where((i) => i.id != cardId).toList();
  }

  Future<void> getCards() async {
    try {
      final cards = await FirestoreCardService().getCards();
      state = cards;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  void addMorrfCreditCard(MorrfCreditCard card) {
    state = [...state, card];
  }
}

final morrfCrediCardProvider =
    StateNotifierProvider<MorrfCreditCardsNotifier, List<MorrfCreditCard>>(
        (ref) {
  return MorrfCreditCardsNotifier();
});
