import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morrf/models/product/morrf_faq.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

class AddFAQPopUp extends StatefulWidget {
  void Function(MorrfFaq value) addFaq;
  AddFAQPopUp({super.key, required this.addFaq});

  @override
  State<AddFAQPopUp> createState() => _AddFAQPopUpState();
}

class _AddFAQPopUpState extends State<AddFAQPopUp> {
  Map<String, String> faqData = {"question": "", "answer": ""};
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
                  text: 'Add FAQ',
                  size: FontSize.h5,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    finish(context);
                  },
                  child: const Icon(FeatherIcons.x, color: kSubTitleColor),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            MorrfInputField(
              inputType: TextInputType.multiline,
              maxLines: 2,
              placeholder: 'Question',
              hint: 'What is your Frequently Asked Question?',
              onChanged: (value) => setState(() {
                faqData["question"] = value;
              }),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 150,
              child: MorrfInputField(
                  onSaved: (value) {
                    setState(() {});
                  },
                  inputType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  maxLength: 150,
                  placeholder: 'Answer',
                  hint: "This should be the answer to the question above.",
                  onChanged: (value) => setState(() {
                        faqData["answer"] = value;
                      })),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: MorrfButton(
                    onPressed: () {
                      finish(context);
                    },
                    child: const MorrfText(text: "Cancel", size: FontSize.h6),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MorrfButton(
                    onPressed: () {
                      widget.addFaq(MorrfFaq(
                          answer: faqData['answer']!,
                          id: Uuid().v4(),
                          question: faqData['question']!));
                      finish(context);
                    },
                    severity: Severity.success,
                    child: const MorrfText(text: "Add", size: FontSize.h6),
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
