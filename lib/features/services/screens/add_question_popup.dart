import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';

class AddQuestionPopUp extends StatefulWidget {
  final void Function(String value) addQuestion;
  const AddQuestionPopUp({super.key, required this.addQuestion});

  @override
  State<AddQuestionPopUp> createState() => _AddQuestionPopUpState();
}

class _AddQuestionPopUpState extends State<AddQuestionPopUp> {
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const MorrfText(
                  text: 'Add Question',
                  size: FontSize.h5,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: const Icon(FeatherIcons.x),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            MorrfInputField(
              controller: questionController,
              inputType: TextInputType.multiline,
              maxLines: 2,
              placeholder: 'Question',
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: MorrfButton(
                    onPressed: () {
                      finish(context);
                    },
                    text: "Cancel",
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MorrfButton(
                    onPressed: () {
                      widget.addQuestion(questionController.text.trim());
                      finish(context);
                    },
                    severity: Severity.success,
                    text: "Add",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
