import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/features/services/add_service/screens/add_question_popup.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceQuestionsScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final MorrfService morrfService;
  final Function(Map<String, dynamic> data) updateService;

  const CreateNewServiceQuestionsScreen({
    super.key,
    required this.isVisible,
    required this.pageChange,
    required this.morrfService,
    required this.updateService,
  });

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
    'description': "",
    'question': [],
  };

  Map<String, dynamic> formState = {};

  late List<String> questionList = widget.morrfService.serviceQuestion;

  void addQuestion(String question) {
    questionList.add(question);
    setState(() {
      createServiceMap['question'] = questionList;
      widget.updateService({'question': questionList});
    });
  }

  //__________Create_Question_PopUP________________________________________________
  void showAddQuestionPopUp() {
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
        const SizedBox(height: 20.0),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  showAddQuestionPopUp();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1.0),
        questionList.isEmpty
            ? const Center(
                child: MorrfText(
                  text: "You haven't listed any questions yet.",
                  size: FontSize.lp,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: buildQuestions.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10.0),
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      title: MorrfText(
                        text: buildQuestions[i],
                        size: FontSize.p,
                        textAlign: TextAlign.left,
                      ),
                      trailing: const FaIcon(FontAwesomeIcons.trashCan),
                    ),
                  );
                },
              ),
        const SizedBox(height: 20),
      ],
    ).visible(widget.isVisible);
  }

  List<String> get buildQuestions {
    List<String> questionEntries = [];

    for (String question in questionList) {
      questionEntries.add(question);
    }

    return questionEntries;
  }
}
