import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/features/services/controller/service_controller.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServicePublishScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final MorrfService morrfService;

  const CreateNewServicePublishScreen(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService});

  @override
  ConsumerState<CreateNewServicePublishScreen> createState() =>
      _CreateNewServicePublishScreenState();
}

class _CreateNewServicePublishScreenState
    extends ConsumerState<CreateNewServicePublishScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  List<Widget> _tiles = [];

  void _onSubmit() async {
    try {
      // ref.read(serviceControllerProvider.notifier).updateNewService(data);
      ref
          .read(serviceControllerProvider.notifier)
          .updateNewService({'trainerId': user.uid});
      MorrfService morrfService = ref.watch(serviceControllerProvider);
      // ref.read(serviceControllerProvider.notifier).createService(morrfService);
      // ref.read(serviceControllerProvider.notifier).disposeNewService();
      Get.offAll(
        () => const RedirectSplashScreen(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            MorrfButton(
              onPressed: () {
                widget.pageChange(5);
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Back",
            ),
            const SizedBox(
              width: 16,
            ),
            MorrfButton(
              severity: Severity.success,
              disabled: _tiles.isEmpty,
              onPressed: () {
                _onSubmit();
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Next",
            ),
          ],
        ),
      ],
    ).visible(widget.isVisible);
  }
}
