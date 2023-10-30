import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_faq.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_dropdown.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'add_faq.dart';
import 'new_service_provider.dart';

class CreateNewServiceTabOne extends ConsumerStatefulWidget {
  bool isVisible;
  Function(int page) pageChange;
  MorrfService morrfService;

  CreateNewServiceTabOne(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService});

  @override
  ConsumerState<CreateNewServiceTabOne> createState() =>
      _CreateNewServiceTabOneState();
}

class _CreateNewServiceTabOneState
    extends ConsumerState<CreateNewServiceTabOne> {
  double? _distanceToField;
  late final TextfieldTagsController _controller = TextfieldTagsController();
  late User user = FirebaseAuth.instance.currentUser!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> createServiceMap = {
    'trainerId': "",
    'title': "",
    'category': "",
    'subcategory': "",
    'serviceType': "",
    'description': "",
    'tags': [],
    'faq': [],
  };

  Map<String, dynamic> formState = {};

  late List<MorrfFaq> faqList = widget.morrfService.faq;

  void addFaq(MorrfFaq faq) {
    faqList.add(faq);
    setState(() {
      createServiceMap['faq'] = faqList;
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
              child: AddFAQPopUp(addFaq: (MorrfFaq value) => addFaq(value)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MorrfService morrfService = ref.watch(newServiceProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        const MorrfText(
          text: 'Overview',
          size: FontSize.h6,
        ),
        const SizedBox(height: 15.0),
        MorrfInputField(
          inputType: TextInputType.name,
          maxLength: 60,
          initialValue: morrfService.title,
          onChanged: (value) => setState(() {
            createServiceMap['title'] = value;
          }),
          placeholder: 'Service Title',
          hint: 'Enter service title',
        ),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Category",
            list: availableCategories,
            initialValue: morrfService.category,
            onChange: (value) => setState(() {
                  createServiceMap['category'] = value;
                }),
            selected: "Personal Training"),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Subcategory",
            list: availableSubcategories,
            initialValue: morrfService.subcategory,
            onChange: (value) => setState(() {
                  createServiceMap['subcategory'] = value;
                }),
            selected: "Something"),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Service Type",
            list: availableServiceTypes,
            initialValue: morrfService.serviceType,
            onChange: (value) => setState(() {
                  createServiceMap['serviceType'] = value;
                }),
            selected: "Online"),
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
            }),
            maxLength: 800,
            placeholder: 'Service Description',
            hint: 'Briefly describe your service...',
          ),
        ),
        const SizedBox(height: 20.0),
        const MorrfText(text: 'Service tags', size: FontSize.h6),
        const SizedBox(height: 15.0),
        TextFieldTags(
          textfieldTagsController: _controller,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          initialTags: morrfService.tags,
          validator: (String tag) {
            if (_controller.getTags!.contains(tag)) {
              return 'you already entered that';
            }

            setState(() {
              createServiceMap['tags'] = [...createServiceMap['tags'], tag];
            });
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextFormField(
                controller: tec,
                focusNode: fn,
                decoration: kInputDecoration.copyWith(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.borderColor,
                        width: 2.0),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.borderColor,
                        width: 2.0),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  hintText: _controller.hasTags ? '' : "Enter tag...",
                  errorText: error,
                  prefixIconConstraints:
                      BoxConstraints(maxWidth: _distanceToField! * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: tags.map((String tag) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                color: Theme.of(context).cardColor,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: MorrfText(
                                      text: tag,
                                      size: FontSize.p,
                                    ),
                                    onTap: () {},
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                    ),
                                    onTap: () {
                                      onTagDelete(tag);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList()),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
              );
            });
          },
        ),
        const SizedBox(height: 5.0),
        const MorrfText(
          text: '5 tags maximum.',
          size: FontSize.p,
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
        const Divider(thickness: 1.0, color: kBorderColorTextField),
        Column(
          children: buildFaqTile(),
        ),
        SizedBox(height: 15),
        SafeArea(
          child: MorrfButton(
            fullWidth: true,
            child: const MorrfText(text: "Next", size: FontSize.h5),
            onPressed: () {
              ref
                  .read(newServiceProvider.notifier)
                  .updateNewService(createServiceMap);
              widget.pageChange(1);
            },
          ),
        ),
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
            iconColor: kLightNeutralColor,
            collapsedIconColor: kLightNeutralColor,
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
