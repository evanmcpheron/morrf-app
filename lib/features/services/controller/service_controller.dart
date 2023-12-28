import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/services/service/service_service.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:uuid/uuid.dart';

final serviceControllerProvider =
    StateNotifierProvider<MorrfServiceNotifier, MorrfService>(
  (ref) => MorrfServiceNotifier(
    serviceService: ref.watch(serviceServiceProvider),
    ref: ref,
  ),
);

class MorrfServiceNotifier extends StateNotifier<MorrfService> {
  User? user = FirebaseAuth.instance.currentUser;
  ServiceService _serviceService;

  MorrfServiceNotifier(
      {required ServiceService serviceService, required Ref ref})
      : _serviceService = serviceService,
        super(MorrfService(
          id: const Uuid().v4(),
          trainerName: '',
          trainerId: '',
          trainerProfileImage: "",
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
        ));

  void disposeNewService() {
    state = MorrfService(
      id: const Uuid().v4(),
      trainerName: '',
      trainerId: '',
      trainerProfileImage: "",
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

  void updateNewService(Map<String, dynamic> data) async {
    data['trainerName'] = user!.displayName;
    data['trainerId'] = user!.uid;
    data['trainerProfileImage'] = user!.photoURL;
    state = MorrfService.fromPartialData(data, state);
  }

  void updateTiers(Map<String, Tier> tiers) {
    state = MorrfService.fromTierData(tiers, state);
  }

  Future<void> createService(MorrfService morrfService) async {
    try {
      await _serviceService.createService(morrfService);
    } catch (e, stacktrace) {
      print(stacktrace);
      rethrow;
    }
  }
}
