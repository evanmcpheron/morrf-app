import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/services/add_service/controller/service_controller.dart';
import 'package:morrf/features/services/add_service/screens/create_new_service_description_screen.dart';
import 'package:morrf/features/services/add_service/screens/create_new_service_images_screen.dart';
import 'package:morrf/features/services/add_service/screens/create_new_service_overview_screen.dart';
import 'package:morrf/features/services/add_service/screens/create_new_service_pricing_screen.dart';
import 'package:morrf/features/services/add_service/screens/create_new_service_questions_screen.dart';
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

  String get stepTitle {
    switch (currentIndexPage) {
      case 0:
        return "Overview";
      case 1:
        return "Pricing";
      case 2:
        return "Descriptions";
      case 3:
        return "Questions";
      case 4:
        return "Images";
      default:
        return "";
    }
  }

  void updateService(Map<String, dynamic> data) {
    ref.read(serviceControllerProvider.notifier).updateNewService(data);
  }

  @override
  Widget build(BuildContext context) {
    MorrfService morrfService = ref.watch(serviceControllerProvider);
    return MorrfScaffold(
      backButton: false,
      title: 'Create New Service',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: currentIndexPage + 1,
                    size: 8,
                    padding: 0,
                    roundedEdges: const Radius.circular(10),
                  ),
                  const SizedBox(height: 10.0),
                  MorrfText(text: stepTitle, size: FontSize.h6),
                ],
              ),
              CreateNewServiceOverviewScreen(
                isVisible: currentIndexPage == 0,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
                updateService: (value) => updateService(value),
              ),
              CreateNewServicePricingScreen(
                isVisible: currentIndexPage == 1,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
                updateService: (value) => updateService(value),
              ),
              CreateNewServiceDescriptionScreen(
                isVisible: currentIndexPage == 2,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
                updateService: (value) => updateService(value),
              ),
              CreateNewServiceQuestionsScreen(
                isVisible: currentIndexPage == 3,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
                updateService: (value) => updateService(value),
              ),
              CreateNewServiceImagesScreen(
                isVisible: currentIndexPage == 4,
                morrfService: morrfService,
                pageChange: (page) {
                  updatePage(page);
                },
                updateService: (value) => updateService(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
