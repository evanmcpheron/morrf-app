import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/stripe/card_model.dart';

class CardService {
  final CollectionReference _cardsCollectionReference =
      FirebaseFirestore.instance.collection("cards");
  User user = FirebaseAuth.instance.currentUser!;

  Future<MorrfCreditCard> createCard(paymentMethodId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('addStripeCard')
          .call(<String, dynamic>{
        'paymentMethod': paymentMethodId,
      });
      final data = result.data['payload'];
      await _cardsCollectionReference.doc(data['id']).set({
        'id': data['id'],
        'userId': user.uid,
        'fingerprint': data['fingerprint'],
        'last4': data['last4'],
        'generatedFrom': data['generatedFrom'],
        'funding': data['funding'],
        'brand': data['brand'],
        'expMonth': data['expMonth'],
        'expYear': data['expYear'],
        'country': data['country'],
        'isDefault': data['isDefault'],
        'createdAt': Timestamp.now(),
      }).then((value) => print("Card Added"));
      return MorrfCreditCard.fromJson({
        'id': data['id'],
        'userId': user.uid,
        'fingerprint': data['fingerprint'],
        'last4': data['last4'],
        'generatedFrom': data['generatedFrom'],
        'funding': data['funding'],
        'brand': data['brand'],
        'expMonth': data['expMonth'],
        'expYear': data['expYear'],
        'country': data['country'],
        'isDefault': data['isDefault'],
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MorrfCreditCard>> getCards() async {
    List<MorrfCreditCard> cards = [];
    final result = await FirebaseFunctions.instance
        .httpsCallable('getCards')
        .call(<String, dynamic>{
      'cardId': user.email,
    });
    final payload = result.data['payload'];
    for (var card in payload) {
      cards.add(MorrfCreditCard.fromJson({
        'id': card['id'],
        'userId': user.uid,
        'last4': card['last4'],
        'generatedFrom': card['generatedFrom'] ?? "",
        'funding': card['funding'],
        'brand': card['brand'],
        'expMonth': card['expMonth'],
        'expYear': card['expYear'],
        'country': card['country'],
        'isDefault': card['isDefault'],
      }));
    }
    return cards;
  }

  Future<List<MorrfCreditCard>> updateDefaultCard(String cardId) async {
    List<MorrfCreditCard> cards = [];
    final result = await FirebaseFunctions.instance
        .httpsCallable('updateDefaultCard')
        .call(<String, dynamic>{'cardId': cardId, 'email': user.email});
    final payload = result.data['payload'];
    for (var card in payload) {
      cards.add(MorrfCreditCard.fromJson({
        'id': card['id'],
        'userId': user.uid,
        'last4': card['last4'],
        'generatedFrom': card['generatedFrom'] ?? "",
        'funding': card['funding'],
        'brand': card['brand'],
        'expMonth': card['expMonth'],
        'expYear': card['expYear'],
        'country': card['country'],
        'isDefault': card['isDefault'],
      }));
    }
    return cards;
  }

  Future<void> deleteCard(String cardId) async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('deleteCard')
        .call(<String, dynamic>{'cardId': cardId, 'email': user.email});
    await _cardsCollectionReference.doc(cardId).delete();
  }
}
