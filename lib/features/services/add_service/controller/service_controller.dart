import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/constants.dart';
import 'package:morrf/features/services/add_service/service/service_service.dart';
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
          category: Constants.availableCategories[0],
          subcategory: Constants.availableSubcategories[0],
          serviceType: Constants.availableServiceTypes[0],
          description: "",
          faq: [],
          serviceQuestion: [],
          tier: Tier(
            deliveryTime: 3,
            options: [],
            title: "",
            revisions: 3,
          ),
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
      category: Constants.availableCategories[0],
      subcategory: Constants.availableSubcategories[0],
      serviceType: Constants.availableServiceTypes[0],
      description: "",
      faq: [],
      serviceQuestion: [],
      tier: Tier(deliveryTime: 3, options: [], title: "", revisions: 3),
      photoUrls: [],
      tags: [],
      heroUrl: "",
      ratings: [],
    );
  }

  void updateNewService(Map<String, dynamic> data) async {
    state = MorrfService.fromPartialData(data, state);
  }

  void updateTiers(Tier tier) {
    state = MorrfService.fromTierData(tier, state);
  }

  Future<void> createService(MorrfService morrfService) async {
    morrfService = MorrfService.fromPartialData(
        {"trainerName": user!.displayName}, morrfService);
    morrfService =
        MorrfService.fromPartialData({"trainerId": user!.uid}, morrfService);
    morrfService = MorrfService.fromPartialData(
        {"trainerProfileImage": user!.photoURL}, morrfService);

    try {
      await _serviceService.createService(morrfService);
    } catch (e, stacktrace) {
      print(stacktrace);
      rethrow;
    }
  }
}
