import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/constants.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/services/controller/service_controller.dart';
import 'package:morrf/features/services/screens/create_new_service_tab_one.dart';
import 'package:morrf/features/services/screens/create_new_service_tab_three.dart';
import 'package:morrf/features/services/screens/create_new_service_tab_two.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CreateNewService extends ConsumerStatefulWidget {
  const CreateNewService({super.key});

  @override
  ConsumerState<CreateNewService> createState() => _CreateNewServiceState();
}

class _CreateNewServiceState extends ConsumerState<CreateNewService> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  late User user = FirebaseAuth.instance.currentUser!;
  double percent = 33.3;

  void updatePage(int page) {
    setState(() {
      currentIndexPage = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MorrfService morrfService = ref.watch(serviceControllerProvider);
    return MorrfScaffold(
      title: 'Create New Service',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MorrfText(
                      text: currentIndexPage == 0
                          ? 'Step 1 of 3'
                          : currentIndexPage == 1
                              ? 'Step 2 of 3'
                              : 'Step 3 of 3',
                      size: FontSize.p),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: currentIndexPage + 1,
                      size: 8,
                      padding: 0,
                      roundedEdges: const Radius.circular(10),
                    ),
                  ),
                ],
              ),
              CreateNewServiceTabOne(
                isVisible: currentIndexPage == 0,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
              ),
              CreateNewServiceTabTwo(
                isVisible: currentIndexPage == 1,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
              ),
              CreateNewServiceTabThree(
                isVisible: currentIndexPage == 2,
                pageChange: (page) {
                  updatePage(page);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleList(String name, bool isSelected, int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: MorrfText(text: name, size: FontSize.p),
      trailing: isSelected
          ? const Icon(
              Icons.radio_button_checked_outlined,
            )
          : const Icon(
              Icons.radio_button_off_outlined,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          Constants.list[index].isSelected = !Constants.list[index].isSelected;
        });
      },
    );
  }
}
