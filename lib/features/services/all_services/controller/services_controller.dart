import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/features/services/all_services/service/services_service.dart';
import 'package:morrf/models/service/morrf_service.dart';

final servicesControllerProvider =
    StateNotifierProvider<MorrfServicesNotifier, List<MorrfService>>(
  (ref) => MorrfServicesNotifier(
    servicesService: ref.watch(servicesServiceProvider),
    ref: ref,
  ),
);

class MorrfServicesNotifier extends StateNotifier<List<MorrfService>> {
  ServicesService _servicesService;
  MorrfServicesNotifier(
      {required ServicesService servicesService, required Ref ref})
      : _servicesService = servicesService,
        super([]);

  Future _init() async {
    state = [];
  }

  Future<void> getServicesByTrainer(String trainerId) async {
    try {
      List<MorrfService> services =
          await _servicesService.getServicesByTrainer(trainerId);

      state = services;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  Future<void> getAllServices() async {
    try {
      List<MorrfService> services = await _servicesService.getAllServices();

      state = services;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}
