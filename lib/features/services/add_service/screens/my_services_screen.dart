import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/core/widgets/morrf_service.dart';
import 'package:morrf/features/services/add_service/controller/services_controller.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'create_new_service_screen.dart';

class MyServicesScreen extends ConsumerStatefulWidget {
  const MyServicesScreen({super.key});

  @override
  ConsumerState<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends ConsumerState<MyServicesScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    ref
        .read(servicesControllerProvider.notifier)
        .getServicesByTrainer(user.uid);
  }

  Future<void> _pullRefresh() async {
    await ref
        .read(servicesControllerProvider.notifier)
        .getServicesByTrainer(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfService?> morrfServices = ref.watch(servicesControllerProvider);

    return MorrfScaffold(
      title: '',
      trailing: const FaIcon(FontAwesomeIcons.plus),
      trailingPressed: () {
        Get.to(() => const CreateNewService());
      },
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 50.0),
                Container(
                  height: 213,
                  width: 269,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/emptyservice.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20.0),
                const MorrfText(
                  text: 'You haven\'t created any services yet.',
                  size: FontSize.h5,
                ),
              ],
            ).visible(morrfServices.isEmpty),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _pullRefresh(),
                child: ListView.builder(
                  itemCount: morrfServices.length,
                  shrinkWrap: true,
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
            ),
          ],
        ),
      ),
    );
  }

  NetworkImage getHeroImage(MorrfService morrfService) {
    return NetworkImage(
        // morrfService.heroUrl,
        "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2F02f83a7d-b16f-4dc8-a61e-415fbef4daa6.jpg?alt=media&token=0914c5dc-d846-493b-a3d1-2f233cde2809");
  }
}
