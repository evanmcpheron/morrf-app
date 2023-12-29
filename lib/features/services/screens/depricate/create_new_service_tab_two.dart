import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/constants/constants.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:morrf/features/services/controller/service_controller.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceTabTwo extends ConsumerStatefulWidget {
  final bool isVisible;
  final MorrfService morrfService;
  final Function(int page) pageChange;

  const CreateNewServiceTabTwo(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService});

  @override
  ConsumerState<CreateNewServiceTabTwo> createState() =>
      _CreateNewServiceTabTwoState();
}

class _CreateNewServiceTabTwoState
    extends ConsumerState<CreateNewServiceTabTwo> {
  final TextEditingController _optionController = TextEditingController();

  Tier tier = Tier(
    deliveryTime: 3,
    price: 0.00,
    title: "",
    options: [],
    revisions: 3,
  );

  //__________DeliveryTime____________________________________________________________
  DropdownButton<int> getDeliveryTime(Tier tier) {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int des in Constants.deliveryTime) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: "$des days", size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(
        FeatherIcons.chevronDown,
        size: 18,
      ),
      items: dropDownItems,
      value: tier.deliveryTime,
      onChanged: (value) {
        setState(() {
          tier.deliveryTime = value!;
        });

        ref.read(serviceControllerProvider.notifier).updateTiers(tier);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const MorrfText(
              text: 'Pricing Package',
              size: FontSize.h6,
            ),
            const SizedBox(height: 15.0),
            KeyboardListener(
              onKeyEvent: (value) {
                if (value.logicalKey.keyLabel == ",") {
                  bool doesOptionExist = tier.options
                      .where((element) =>
                          element?.title ==
                          _optionController.text.replaceAll(RegExp(','), ''))
                      .isEmpty;

                  _optionController.text.replaceAll(RegExp(','), '');
                  if (_optionController.text.replaceAll(RegExp(','), '') !=
                          "" &&
                      doesOptionExist) {
                    setState(() {
                      tier.options = [
                        ...tier.options,
                        Option(
                          _optionController.text.replaceAll(RegExp(','), ''),
                          false,
                        )
                      ];
                      tier.options = [
                        ...tier.options,
                        Option(
                          _optionController.text.replaceAll(RegExp(','), ''),
                          false,
                        )
                      ];
                      tier.options = [
                        ...tier.options,
                        Option(
                          _optionController.text.replaceAll(RegExp(','), ''),
                          false,
                        )
                      ];

                      _optionController.clear();
                    });
                  } else {
                    _optionController.clear();
                  }
                }
              },
              focusNode: FocusNode(),
              child: MorrfInputField(
                  placeholder: 'Package Options',
                  controller: _optionController),
            ),
            const SizedBox(height: 15.0),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  padding: const EdgeInsets.all(10.0),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.zero,
                      title: const MorrfText(
                        text: 'Basic Package',
                        size: FontSize.h5,
                      ),
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 4),
                          contentPadding: EdgeInsets.zero,
                          title:
                              const MorrfText(text: 'Price', size: FontSize.p),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MorrfText(
                                  text: Constants.currencySign,
                                  size: FontSize.h6),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 100.0,
                                child: MorrfInputField(
                                  inputType: TextInputType.number,
                                  onChanged: (value) => setState(() {
                                    tier.price = value.toDouble();
                                  }),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  placeholder: 'price',
                                  initialValue: tier.price?.toStringAsFixed(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 4),
                          contentPadding: EdgeInsets.zero,
                          title: const MorrfText(
                              text: 'Revisions', size: FontSize.p),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: MorrfInputField(
                                  inputType: TextInputType.number,
                                  onChanged: (value) => setState(() {
                                    tier.revisions = value.toInt();
                                  }),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  placeholder: 'revisions',
                                  initialValue: tier.revisions.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          title: const MorrfText(
                              text: 'Delivery Time', size: FontSize.p),
                          trailing: DropdownButtonHideUnderline(
                              child: getDeliveryTime(tier)),
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                        ),
                        tier.options.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: tier.options.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  // return item
                                  return Column(
                                    children: [
                                      titleList(
                                        tier,
                                        index,
                                      ),
                                      const Divider(
                                        height: 0.0,
                                        thickness: 1.0,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: MorrfText(
                                    text: "Add package options here.",
                                    size: FontSize.h6),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
              ],
            ),
            SafeArea(
              child: Row(
                children: [
                  MorrfButton(
                    onPressed: () {
                      widget.pageChange(0);
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
                      widget.pageChange(2);
                    },
                    width: MediaQuery.of(context).size.width / 2 - 23,
                    text: "Next",
                  ),
                ],
              ),
            )
          ],
        ).visible(widget.isVisible),
      ],
    );
  }

  Widget titleList(Tier tier, int index) {
    if (tier.options.isEmpty) {
      return const MorrfText(
          text: "Enter some special options to sell higher packages!",
          size: FontSize.h5);
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: MorrfText(text: tier.options[index]!.title, size: FontSize.p),
        trailing: tier.options[index]!.isSelected
            ? const Icon(
                Icons.radio_button_checked_outlined,
              )
            : const Icon(
                Icons.radio_button_off_outlined,
                color: Colors.grey,
              ),
        onTap: () {
          setState(() {
            tier.options[index]!.isSelected = !tier.options[index]!.isSelected;
          });
        },
      );
    }
  }
}
