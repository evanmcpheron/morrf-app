import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/payments/service/payment_service.dart';
import 'package:morrf/models/stripe/card_model.dart';

class MorrfCreditCardsNotifier extends StateNotifier<List<MorrfCreditCard>> {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  MorrfCreditCardsNotifier() : super([]);

  Future<void> createCard(String paymentMethodId) async {
    final card = await CardService().createCard(paymentMethodId);
    state = [card, ...state];
  }

  Future<void> updateDefaultCard(String cardId) async {
    try {
      final cards = await CardService().updateDefaultCard(cardId);
      state = cards;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCard(String cardId) async {
    await CardService().deleteCard(cardId);
    state = state.where((i) => i.id != cardId).toList();
  }

  Future<void> getCards() async {
    try {
      final cards = await CardService().getCards();
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
