import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/services/service/services_service.dart';
import 'package:morrf/models/service/morrf_service.dart';

final servicesControllerProvider =
    StateNotifierProvider<MorrfServicesNotifier, List<MorrfService>>(
  (ref) => MorrfServicesNotifier(
    servicesService: ref.watch(servicesServiceProvider),
    ref: ref,
  ),
);

final getServicesByUserIdDataProvider =
    StreamProvider.family((ref, String uid) {
  final servicesController = ref.watch(servicesControllerProvider.notifier);
  return servicesController.getServicesByTrainer(uid);
});

class MorrfServicesNotifier extends StateNotifier<List<MorrfService>> {
  ServicesService _servicesService;
  MorrfServicesNotifier(
      {required ServicesService servicesService, required Ref ref})
      : _servicesService = servicesService,
        super([]);

  Future _init() async {
    state = [];
  }

  Stream<List<MorrfService>> getServicesByTrainer(String trainerId) {
    return _servicesService.getServicesByTrainer(trainerId);
  }
}
