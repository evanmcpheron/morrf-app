import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/features/services/screens/add_question_popup.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceQuestionsScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final MorrfService morrfService;

  const CreateNewServiceQuestionsScreen(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService});

  @override
  ConsumerState<CreateNewServiceQuestionsScreen> createState() =>
      _CreateNewServiceQuestionsScreenState();
}

class _CreateNewServiceQuestionsScreenState
    extends ConsumerState<CreateNewServiceQuestionsScreen> {
  late User user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> createServiceMap = {
    'trainerName': "",
    'title': "",
    'category': "",
    'subcategory': "",
    'serviceType': "",
    'description': "",
    'tags': [],
    'question': [],
  };

  Map<String, dynamic> formState = {};

  late List<String> questionList = widget.morrfService.serviceQuestion;

  void addQuestion(String question) {
    questionList.add(question);
    setState(() {
      createServiceMap['question'] = questionList;
    });
  }

  //__________Create_FAQ_PopUP________________________________________________
  void showAddFAQPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: AddQuestionPopUp(
                  addQuestion: (String value) => addQuestion(value)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showAddFAQPopUp();
              },
              child: const MorrfText(text: 'Add question', size: FontSize.p),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1.0),
        Column(
          children: buildQuestions(),
        ),
        const SizedBox(height: 20),
        SafeArea(
          child: Row(
            children: [
              MorrfButton(
                onPressed: () {
                  widget.pageChange(2);
                },
                width: MediaQuery.of(context).size.width / 2 - 23,
                text: "Back",
              ),
              const SizedBox(
                width: 16,
              ),
              MorrfButton(
                severity: Severity.success,
                onPressed: () {
                  widget.pageChange(4);
                },
                width: MediaQuery.of(context).size.width / 2 - 23,
                text: "Next",
              ),
            ],
          ),
        )
      ],
    ).visible(widget.isVisible);
  }

  List<Widget> buildQuestions() {
    List<Widget> questionEntries = [];

    if (questionList.isEmpty) {
      return [
        const MorrfText(
          text: "You haven't listed any questions yet",
          size: FontSize.h4,
          textAlign: TextAlign.center,
        )
      ];
    }

    for (String question in questionList) {
      questionEntries.add(
        Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: MorrfText(
              text: question,
              size: FontSize.p,
            )),
      );
    }

    return questionEntries;
  }
}
