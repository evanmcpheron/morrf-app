import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/constants/constants.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_dropdown.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:morrf/features/services/add_service/controller/service_controller.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CreateNewServiceOverviewScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final Function(Map<String, dynamic> data) updateService;
  final MorrfService morrfService;

  const CreateNewServiceOverviewScreen(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService,
      required this.updateService});

  @override
  ConsumerState<CreateNewServiceOverviewScreen> createState() =>
      _CreateNewServiceOverviewScreenState();
}

class _CreateNewServiceOverviewScreenState
    extends ConsumerState<CreateNewServiceOverviewScreen> {
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

  List<String> tags = [];

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
                ref
                    .read(serviceControllerProvider.notifier)
                    .disposeNewService();
                Get.back();
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
                if (widget.morrfService.title.trim() == "") {
                  const snackBar = SnackBar(
                    content: MorrfText(
                        text: 'Don\'t forget to add a title',
                        size: FontSize.h5,
                        textAlign: TextAlign.center),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  widget.pageChange(1);
                  widget.updateService({"tags": _controller.getTags});
                }
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Next",
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        MorrfInputField(
          inputType: TextInputType.name,
          maxLength: 60,
          initialValue: morrfService.title,
          onChanged: (value) => setState(() {
            widget.updateService({"title": value.trim()});
          }),
          placeholder: 'Service Title',
          hint: 'Enter service title',
        ),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Category",
            list: Constants.availableCategories,
            initialValue: morrfService.category,
            onChange: (value) => setState(() {
                  widget.updateService({"category": value});
                }),
            selected: "Personal Training"),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Subcategory",
            list: Constants.availableSubcategories,
            initialValue: morrfService.subcategory,
            onChange: (value) => setState(() {
                  widget.updateService({"subcategory": value});
                }),
            selected: "Something"),
        const SizedBox(height: 20.0),
        MorrfDrowpdown(
            label: "Service Type",
            list: Constants.availableServiceTypes,
            initialValue: morrfService.serviceType,
            onChange: (value) => setState(() {
                  widget.updateService({"serviceType": value});
                }),
            selected: "Online"),
        const SizedBox(height: 20.0),
        const MorrfText(text: 'Service tags', size: FontSize.h6),
        const SizedBox(height: 20.0),
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
              tags = [...tags, tag];
              widget.updateService({"tags": tags});
            });
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextFormField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
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
      ],
    ).visible(widget.isVisible);
  }
}
