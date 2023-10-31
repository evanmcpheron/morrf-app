import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/services/firestore/firestore_service.dart';
import 'package:uuid/uuid.dart';

class NewServiceNotifier extends StateNotifier<MorrfService> {
  User user = FirebaseAuth.instance.currentUser!;
  NewServiceNotifier()
      : super(
          MorrfService(
            id: Uuid().v4(),
            trainerId: '',
            title: "",
            category: "",
            subcategory: "",
            serviceType: "",
            description: "",
            faq: [],
            tiers: {
              "basic": Tier(
                  deliveryTime: 3,
                  options: [],
                  title: "",
                  revisions: 3,
                  isVisible: true),
              "standard": Tier(
                  deliveryTime: 3,
                  options: [],
                  title: "",
                  revisions: 3,
                  isVisible: true),
              "premium": Tier(
                  deliveryTime: 3,
                  options: [],
                  title: "",
                  revisions: 3,
                  isVisible: true)
            },
            photoUrls: [],
            tags: [],
            heroUrl: "",
            ratings: [],
          ),
        );

  void updateNewService(Map<String, dynamic> data) async {
    data['trainerId'] = user.uid;
    state = MorrfService.fromPartialData(data, state);
  }

  void updateTiers(Map<String, Tier> tiers) {
    state = MorrfService.fromTierData(tiers, state);
  }

  Future<void> createService(MorrfService morrfService) async {
    try {
      await FirestoreService().createService(morrfService);
    } catch (e, stacktrace) {
      print(stacktrace);
      rethrow;
    }
  }

  void disposeNewService() {
    state = MorrfService(
      id: Uuid().v4(),
      trainerId: '',
      title: "",
      category: "",
      subcategory: "",
      serviceType: "",
      description: "",
      faq: [],
      tiers: {
        "basic": Tier(
            deliveryTime: 3,
            options: [],
            title: "",
            revisions: 3,
            isVisible: true),
        "standard": Tier(
            deliveryTime: 3,
            options: [],
            title: "",
            revisions: 3,
            isVisible: true),
        "premium": Tier(
            deliveryTime: 3,
            options: [],
            title: "",
            revisions: 3,
            isVisible: true)
      },
      photoUrls: [],
      tags: [],
      heroUrl: "",
      ratings: [],
    );
  }
}

final newServiceProvider =
    StateNotifierProvider<NewServiceNotifier, MorrfService>((ref) {
  return NewServiceNotifier();
});
