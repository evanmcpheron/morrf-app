import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/product/morrf_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/services/firestore/firestore_product.dart';
import 'package:uuid/uuid.dart';

class NewServiceNotifier extends StateNotifier<MorrfProduct> {
  User user = FirebaseAuth.instance.currentUser!;
  NewServiceNotifier()
      : super(
          MorrfProduct(
            id: Uuid().v4(),
            trainerId: '',
            title: "",
            category: "",
            subcategory: "",
            serviceType: "",
            description: "",
            faq: [],
            tiers: {
              "basic": Tier(deliveryTime: 3, options: [], isVisible: true),
              "standard": Tier(deliveryTime: 3, options: [], isVisible: true),
              "premium": Tier(deliveryTime: 3, options: [], isVisible: true)
            },
            photoUrls: [],
            tags: [],
            heroUrl: "",
            ratings: [],
          ),
        );

  void updateNewProduct(Map<String, dynamic> data) async {
    data['trainerId'] = user.uid;
    state = MorrfProduct.fromPartialData(data, state);
  }

  void updateTiers(Map<String, Tier> tiers) {
    state = MorrfProduct.fromTierData(tiers, state);
  }

  Future<void> createService(MorrfProduct morrfProduct) async {
    try {
      await FirestoreProduct().createProduct(morrfProduct);
    } catch (e, stacktrace) {
      print(stacktrace);
      rethrow;
    }
  }

  void disposeNewService() {
    state = MorrfProduct(
      id: Uuid().v4(),
      trainerId: '',
      title: "",
      category: "",
      subcategory: "",
      serviceType: "",
      description: "",
      faq: [],
      tiers: {
        "basic": Tier(deliveryTime: 3, options: [], isVisible: true),
        "standard": Tier(deliveryTime: 3, options: [], isVisible: true),
        "premium": Tier(deliveryTime: 3, options: [], isVisible: true)
      },
      photoUrls: [],
      tags: [],
      heroUrl: "",
      ratings: [],
    );
  }
}

final newServiceProvider =
    StateNotifierProvider<NewServiceNotifier, MorrfProduct>((ref) {
  return NewServiceNotifier();
});
