import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/core/widgets/morrf_service.dart';
import 'package:morrf/features/services/all_services/controller/services_controller.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class AllServicesScreen extends ConsumerStatefulWidget {
  const AllServicesScreen({super.key});

  @override
  ConsumerState<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends ConsumerState<AllServicesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(servicesControllerProvider.notifier).getAllServices();
  }

  Future<void> _pullRefresh() async {
    await ref.read(servicesControllerProvider.notifier).getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfService?> morrfServices = ref.watch(servicesControllerProvider);

    return MorrfScaffold(
      title: '',
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(),
        child: ListView.builder(
          itemCount: morrfServices.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            MorrfService morrfService = morrfServices[index]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Get.to(() => ServiceDetails(serviceId: morrfService.id));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(),
                  ),
                  child: MorrfServiceWidget(
                    morrfService: morrfService,
                  ),
                ),
              ),
            );
          },
        ).visible(morrfServices.isNotEmpty),
      ),
    );
  }

  NetworkImage getHeroImage(MorrfService morrfService) {
    return const NetworkImage(
        // morrfService.heroUrl,
        "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2F02f83a7d-b16f-4dc8-a61e-415fbef4daa6.jpg?alt=media&token=0914c5dc-d846-493b-a3d1-2f233cde2809");
  }
}
