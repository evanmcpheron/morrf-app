import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/product/morrf_product.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/create_new_service_tab_one.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/create_new_service_tab_three.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/create_new_service_tab_two.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'new_service_provider.dart';

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
    MorrfProduct morrfProduct = ref.watch(newServiceProvider);
    return MorrfScaffold(
      title: 'Create New Service',
      body: Container(
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
                      selectedColor: kPrimaryColor,
                      unselectedColor: kPrimaryColor.withOpacity(0.2),
                      roundedEdges: const Radius.circular(10),
                    ),
                  ),
                ],
              ),
              CreateNewServiceTabOne(
                isVisible: currentIndexPage == 0,
                morrfProduct: morrfProduct,
                pageChange: (page) {
                  updatePage(page);
                },
              ),
              CreateNewServiceTabTwo(
                isVisible: currentIndexPage == 1,
                morrfProduct: morrfProduct,
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
              color: kPrimaryColor,
            )
          : const Icon(
              Icons.radio_button_off_outlined,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          list[index].isSelected = !list[index].isSelected;
        });
      },
    );
  }
}
