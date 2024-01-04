import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:morrf/features/services/add_service/controller/service_controller.dart';
import 'package:morrf/features/services/add_service/screens/add_faq.dart';
import 'package:morrf/models/service/morrf_faq.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceDescriptionScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final MorrfService morrfService;
  final Function(Map<String, dynamic> data) updateService;

  const CreateNewServiceDescriptionScreen(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService,
      required this.updateService});

  @override
  ConsumerState<CreateNewServiceDescriptionScreen> createState() =>
      _CreateNewServiceDescriptionScreenState();
}

class _CreateNewServiceDescriptionScreenState
    extends ConsumerState<CreateNewServiceDescriptionScreen> {
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
    'faq': [],
  };

  Map<String, dynamic> formState = {};

  late List<MorrfFaq> faqList = widget.morrfService.faq;

  void addFaq(MorrfFaq faq) {
    faqList.add(faq);
    setState(() {
      createServiceMap['faq'] = faqList;
    });
    widget.updateService({"faq": faqList});
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
              child: AddFAQPopUp(addFaq: (MorrfFaq value) => addFaq(value)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MorrfService morrfService = ref.watch(serviceControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Row(
          children: [
            MorrfButton(
              onPressed: () {
                widget.pageChange(1);
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
                widget.pageChange(3);
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Next",
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 150,
          child: MorrfInputField(
            inputType: TextInputType.multiline,
            maxLines: null,
            initialValue: morrfService.description,
            expands: true,
            onChanged: (value) => setState(() {
              createServiceMap['description'] = value;
              widget.updateService({"description": value});
            }),
            maxLength: 800,
            placeholder: 'Service Description',
            hint: 'Briefly describe your service...',
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const MorrfText(
                text: 'Frequently Asked Question', size: FontSize.h6),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showAddFAQPopUp();
              },
              child: const MorrfText(text: 'Add FAQ', size: FontSize.p),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1.0),
        Column(
          children: buildFaqTile(),
        ),
        const SizedBox(height: 15),
      ],
    ).visible(widget.isVisible);
  }

  List<Widget> buildFaqTile() {
    List<Widget> faqEntries = [];

    if (faqList.isEmpty) {
      return [
        const MorrfText(
          text: "You haven't listed an FAQ yet",
          size: FontSize.h4,
          textAlign: TextAlign.center,
        )
      ];
    }

    for (MorrfFaq faq in faqList) {
      String question = faq.question;
      String answer = faq.answer;

      faqEntries.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: MorrfText(
              text: question,
              size: FontSize.p,
            ),
            children: [
              MorrfText(
                text: answer,
                size: FontSize.p,
              )
            ],
          ),
        ),
      );
    }

    return faqEntries;
  }
}
