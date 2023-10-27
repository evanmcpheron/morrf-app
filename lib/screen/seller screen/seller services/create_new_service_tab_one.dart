import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home.dart';
import 'package:morrf/screen/seller%20screen/seller%20popUp/seller_popup.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/button_global.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../widgets/constant.dart';
import 'create_service.dart';

class CreateNewServiceTabOne extends StatefulWidget {
  bool isVisible;
  CreateNewServiceTabOne({super.key, required this.isVisible});

  @override
  State<CreateNewServiceTabOne> createState() => _CreateNewServiceTabOneState();
}

class _CreateNewServiceTabOneState extends State<CreateNewServiceTabOne> {
  //__________Category____________________________________________________________
  DropdownButton<String> getCategory() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in category) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: des, size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedCategory,
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
    );
  }

  //__________SubCategory____________________________________________________________
  DropdownButton<String> getSubCategory() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in subcategory) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: des, size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedSubCategory,
      onChanged: (value) {
        setState(() {
          selectedSubCategory = value!;
        });
      },
    );
  }

  //__________ServiceType____________________________________________________________
  DropdownButton<String> getServiceType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in serviceType) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: des, size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedServiceType,
      onChanged: (value) {
        setState(() {
          selectedServiceType = value!;
        });
      },
    );
  }

  double? _distanceToField;
  final TextfieldTagsController _controller = TextfieldTagsController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<String> serviceTags = const [
    'UI UX Design',
    'Flutter',
    'Java',
    'Graphic',
    'language'
  ];

  @override
  void initState() {
    super.initState();
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
              child: const AddFAQPopUp(),
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
        const MorrfText(
          text: 'Overview',
          size: FontSize.h6,
        ),
        const SizedBox(height: 15.0),
        const MorrfInputField(
          inputType: TextInputType.name,
          maxLength: 60,
          placeholder: 'Service Title',
          hint: 'Enter service title',
        ),
        const SizedBox(height: 20.0),
        FormField(
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                constraints: const BoxConstraints(maxHeight: 56),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: "Category",
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                ),
              ),
              child: DropdownButtonHideUnderline(child: getCategory()),
            );
          },
        ),
        const SizedBox(height: 20.0),
        FormField(
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                constraints: const BoxConstraints(maxHeight: 56),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: "Subcategory",
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                ),
              ),
              child: DropdownButtonHideUnderline(child: getSubCategory()),
            );
          },
        ),
        const SizedBox(height: 20.0),
        FormField(
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                constraints: const BoxConstraints(maxHeight: 56),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                labelText: "Service Type",
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide:
                      BorderSide(color: borderColor(context), width: 2.0),
                ),
              ),
              child: DropdownButtonHideUnderline(child: getServiceType()),
            );
          },
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 150,
          child: MorrfInputField(
            onSaved: (value) {
              setState(() {
                value.toString();
              });
            },
            inputType: TextInputType.multiline,
            maxLines: null,
            expands: true,
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
          validator: (String tag) {
            if (tag == 'php') {
              return 'Try else';
            } else if (_controller.getTags!.contains(tag)) {
              return 'you already entered that';
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextFormField(
                controller: tec,
                focusNode: fn,
                decoration: kInputDecoration.copyWith(
                  border: const OutlineInputBorder(),
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
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: const ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            iconColor: kLightNeutralColor,
            collapsedIconColor: kLightNeutralColor,
            title: MorrfText(
              text: 'What software is used to create the design?',
              size: FontSize.p,
            ),
            children: [
              MorrfText(
                text:
                    'I can use Figma , Adobe XD or Framer , whatever app your comfortable working with',
                size: FontSize.p,
              )
            ],
          ),
        ),
        const Divider(thickness: 1.0, color: kBorderColorTextField),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: const ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            iconColor: kLightNeutralColor,
            collapsedIconColor: kLightNeutralColor,
            title: MorrfText(
              text: 'What software is used to create the design?',
              size: FontSize.p,
            ),
            children: [
              MorrfText(
                text:
                    'I can use Figma , Adobe XD or Framer , whatever app your comfortable working with',
                size: FontSize.p,
              )
            ],
          ),
        ),
        const Divider(thickness: 1.0, color: kBorderColorTextField)
      ],
    ).visible(widget.isVisible);
  }
}
