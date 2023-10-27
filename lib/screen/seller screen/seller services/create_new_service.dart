import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home.dart';
import 'package:morrf/screen/seller%20screen/seller%20services/create_new_service_tab_one.dart';
import 'package:morrf/screen/seller%20screen/seller%20services/create_new_service_tab_three.dart';
import 'package:morrf/screen/seller%20screen/seller%20services/create_new_service_tab_two.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CreateNewService extends StatefulWidget {
  const CreateNewService({super.key});

  @override
  State<CreateNewService> createState() => _CreateNewServiceState();
}

class _CreateNewServiceState extends State<CreateNewService> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  double percent = 33.3;

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
    return MorrfScaffold(
      title: 'Create New Service',
      body: PageView.builder(
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int index) => setState(() => currentIndexPage = index),
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
              ),
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
                    CreateNewServiceTabOne(isVisible: currentIndexPage == 0),
                    CreateNewServiceTabTwo(isVisible: currentIndexPage == 1),
                    CreateNewServiceTabThree(isVisible: currentIndexPage == 2),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: MorrfButton(
                          fullWidth: true,
                          child:
                              const MorrfText(text: "Next", size: FontSize.h5),
                          onPressed: () {
                            currentIndexPage < 2;
                            currentIndexPage < 2
                                ? pageController.nextPage(
                                    duration:
                                        const Duration(microseconds: 3000),
                                    curve: Curves.bounceInOut)
                                : Get.offAll(() => SellerHome());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
