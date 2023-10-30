import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/product/morrf_product.dart';
import 'package:morrf/services/firestore/firestore_billing/firestore_card.dart';
import 'package:morrf/services/firestore/firestore_product.dart';

class MorrfProductNotifier extends StateNotifier<List<MorrfProduct>> {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  MorrfProductNotifier() : super([]);

  Future<void> deleteProduct(String cardId) async {
    await FirestoreCardService().deleteCard(cardId);
    state = state.where((i) => i.id != cardId).toList();
  }

  Future<void> getProductsByTrainer(String trainerId) async {
    try {
      var products = await FirestoreProduct().getProductsByTrainer(trainerId);
      print("PRODUCTS: $products");
      // state = products;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}

final morrfProductProvider =
    StateNotifierProvider<MorrfProductNotifier, List<MorrfProduct>>((ref) {
  return MorrfProductNotifier();
});
