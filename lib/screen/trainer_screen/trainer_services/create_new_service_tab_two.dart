import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/new_service_provider.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceTabTwo extends ConsumerStatefulWidget {
  bool isVisible;
  MorrfService morrfService;
  Function(int page) pageChange;

  CreateNewServiceTabTwo(
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

  Map<String, Tier> tiers = {
    "basic": Tier(
        deliveryTime: 3,
        price: 0.00,
        title: "",
        options: [],
        revisions: 3,
        isVisible: true),
    "standard": Tier(
        deliveryTime: 3,
        price: 0.00,
        title: "",
        options: [],
        revisions: 3,
        isVisible: true),
    "premium": Tier(
        deliveryTime: 3,
        price: 0.00,
        title: "",
        options: [],
        revisions: 3,
        isVisible: true)
  };

  //__________DeliveryTime____________________________________________________________
  DropdownButton<int> getDeliveryTime(String tier) {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int des in deliveryTime) {
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
      value: tiers[tier]!.deliveryTime,
      onChanged: (value) {
        setState(() {
          tiers[tier]!.deliveryTime = value!;
        });

        ref.read(newServiceProvider.notifier).updateTiers(tiers);
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
    MorrfService morrfService = ref.watch(newServiceProvider);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: morrfService.tiers["basic"]!.isVisible,
                      onChanged: (bool? nValue) {
                        if (!nValue! &&
                            !tiers["standard"]!.isVisible &&
                            !tiers["premium"]!.isVisible) {
                          setState(() {
                            tiers["basic"]!.isVisible = nValue;
                            tiers["standard"]!.isVisible = true;
                          });
                        } else {
                          setState(() {
                            tiers["basic"]!.isVisible = nValue;
                          });
                        }
                        ref
                            .read(newServiceProvider.notifier)
                            .updateTiers(tiers);
                      },
                    ),
                    const MorrfText(text: "Basic", size: FontSize.p)
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: morrfService.tiers["standard"]!.isVisible,
                      onChanged: (bool? nValue) {
                        if (!nValue! &&
                            !tiers["basic"]!.isVisible &&
                            !tiers["premium"]!.isVisible) {
                          setState(() {
                            tiers["standard"]!.isVisible = true;
                          });
                        } else {
                          setState(() {
                            tiers["standard"]!.isVisible = nValue;
                          });
                        }
                        ref
                            .read(newServiceProvider.notifier)
                            .updateTiers(tiers);
                      },
                    ),
                    const MorrfText(text: "Standard", size: FontSize.p)
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: morrfService.tiers["premium"]!.isVisible,
                      onChanged: (bool? nValue) {
                        if (!nValue! &&
                            !tiers["standard"]!.isVisible &&
                            !tiers["basic"]!.isVisible) {
                          setState(() {
                            tiers["premium"]!.isVisible = nValue;
                            tiers["standard"]!.isVisible = true;
                          });
                        } else {
                          setState(() {
                            tiers["premium"]!.isVisible = nValue;
                          });
                        }

                        ref
                            .read(newServiceProvider.notifier)
                            .updateTiers(tiers);
                      },
                    ),
                    const MorrfText(text: "Premium", size: FontSize.p)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            KeyboardListener(
              onKeyEvent: (value) {
                if (value.logicalKey.keyLabel == ",") {
                  bool doesOptionExist = tiers["basic"]!
                      .options
                      .where((element) =>
                          element?.title ==
                          _optionController.text.replaceAll(RegExp(','), ''))
                      .isEmpty;

                  _optionController.text.replaceAll(RegExp(','), '');
                  if (_optionController.text.replaceAll(RegExp(','), '') !=
                          "" &&
                      doesOptionExist) {
                    setState(() {
                      tiers["basic"]!.options = [
                        ...tiers["basic"]!.options,
                        Option(
                          _optionController.text.replaceAll(RegExp(','), ''),
                          false,
                        )
                      ];
                      tiers["standard"]!.options = [
                        ...tiers["standard"]!.options,
                        Option(
                          _optionController.text.replaceAll(RegExp(','), ''),
                          false,
                        )
                      ];
                      tiers["premium"]!.options = [
                        ...tiers["premium"]!.options,
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
            widget.morrfService.tiers["basic"]!.isVisible
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: kBorderColorTextField)),
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,
                            iconColor: kLightNeutralColor,
                            collapsedIconColor: kLightNeutralColor,
                            title: const MorrfText(
                              text: 'Basic Package',
                              size: FontSize.h5,
                            ),
                            children: [
                              ListTile(
                                visualDensity: const VisualDensity(vertical: 4),
                                contentPadding: EdgeInsets.zero,
                                title: const MorrfText(
                                    text: 'Price', size: FontSize.p),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const MorrfText(
                                        text: currencySign, size: FontSize.h6),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: MorrfInputField(
                                        inputType: TextInputType.number,
                                        onChanged: (value) => setState(() {
                                          tiers["basic"]!.price =
                                              value.toDouble();
                                        }),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        placeholder: 'price',
                                        initialValue: tiers["basic"]!
                                            .price
                                            ?.toStringAsFixed(2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
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
                                          tiers["basic"]!.revisions =
                                              value.toInt();
                                        }),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        placeholder: 'revisions',
                                        initialValue: tiers["basic"]!
                                            .revisions
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                              ListTile(
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                contentPadding: EdgeInsets.zero,
                                title: const MorrfText(
                                    text: 'Delivery Time', size: FontSize.p),
                                trailing: DropdownButtonHideUnderline(
                                    child: getDeliveryTime("basic")),
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                              tiers["basic"]!.options.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: tiers["basic"]!.options.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // return item
                                        return Column(
                                          children: [
                                            titleList(
                                              "basic",
                                              index,
                                            ),
                                            const Divider(
                                              height: 0.0,
                                              thickness: 1.0,
                                              color: kBorderColorTextField,
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
                  )
                : const SizedBox(),
            widget.morrfService.tiers["standard"]!.isVisible
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: kBorderColorTextField)),
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: false,
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,
                            iconColor: kLightNeutralColor,
                            collapsedIconColor: kLightNeutralColor,
                            title: const MorrfText(
                              text: 'Standard Package',
                              size: FontSize.h6,
                            ),
                            children: [
                              ListTile(
                                visualDensity: const VisualDensity(vertical: 4),
                                contentPadding: EdgeInsets.zero,
                                title: const MorrfText(
                                    text: 'Price', size: FontSize.p),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const MorrfText(
                                        text: currencySign, size: FontSize.h6),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: MorrfInputField(
                                        inputType: TextInputType.number,
                                        onChanged: (value) => setState(() {
                                          tiers["standard"]!.price =
                                              value.toDouble();
                                        }),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        initialValue: tiers["standard"]!
                                            .price
                                            ?.toStringAsFixed(2),
                                        placeholder: 'price',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
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
                                          tiers["standard"]!.revisions =
                                              value.toInt();
                                        }),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        placeholder: 'revisions',
                                        initialValue: tiers["standard"]!
                                            .revisions
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                visualDensity:
                                    const VisualDensity(vertical: -4),
                                contentPadding: EdgeInsets.zero,
                                title: const MorrfText(
                                  text: 'Delivery Time',
                                  size: FontSize.p,
                                ),
                                trailing: DropdownButtonHideUnderline(
                                    child: getDeliveryTime("standard")),
                              ),
                              const Divider(
                                height: 0.0,
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                              tiers["standard"]!.options.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          tiers["standard"]!.options.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // return item
                                        return Column(
                                          children: [
                                            titleList(
                                              "standard",
                                              index,
                                            ),
                                            const Divider(
                                              height: 0.0,
                                              thickness: 1.0,
                                              color: kBorderColorTextField,
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
                  )
                : const SizedBox(),
            widget.morrfService.tiers["premium"]!.isVisible
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: kBorderColorTextField)),
                    padding: const EdgeInsets.all(10.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        iconColor: kLightNeutralColor,
                        collapsedIconColor: kLightNeutralColor,
                        title: const MorrfText(
                          text: 'Premium Package',
                          size: FontSize.h6,
                        ),
                        children: [
                          ListTile(
                            visualDensity: const VisualDensity(vertical: 4),
                            contentPadding: EdgeInsets.zero,
                            title: const MorrfText(
                                text: 'Price', size: FontSize.p),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const MorrfText(
                                    text: currencySign, size: FontSize.h6),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: MorrfInputField(
                                    inputType: TextInputType.number,
                                    onChanged: (value) => setState(() {
                                      tiers["premium"]!.price =
                                          value.toDouble();
                                    }),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    placeholder: 'price',
                                    initialValue: tiers["premium"]!
                                        .price
                                        ?.toStringAsFixed(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 0.0,
                            thickness: 1.0,
                            color: kBorderColorTextField,
                          ),
                          const Divider(
                            height: 0.0,
                            thickness: 1.0,
                            color: kBorderColorTextField,
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
                                      tiers["premium"]!.revisions =
                                          value.toInt();
                                    }),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    placeholder: 'revisions',
                                    initialValue:
                                        tiers["premium"]!.revisions.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: const MorrfText(
                              text: 'Delivery Time',
                              size: FontSize.p,
                            ),
                            trailing: DropdownButtonHideUnderline(
                                child: getDeliveryTime("premium")),
                          ),
                          const Divider(
                            height: 0.0,
                            thickness: 1.0,
                            color: kBorderColorTextField,
                          ),
                          tiers["premium"]!.options.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: tiers["premium"]!.options.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // return item
                                    return Column(
                                      children: [
                                        titleList(
                                          "premium",
                                          index,
                                        ),
                                        const Divider(
                                          height: 0.0,
                                          thickness: 1.0,
                                          color: kBorderColorTextField,
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
                  )
                : const SizedBox(),
            const SizedBox(height: 15.0),
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

  Widget titleList(String tier, int index) {
    if (tiers[tier]!.options.isEmpty) {
      return const MorrfText(
          text: "Enter some special options to sell higher packages!",
          size: FontSize.h5);
    } else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: MorrfText(
            text: tiers[tier]!.options[index]!.title, size: FontSize.p),
        trailing: tiers[tier]!.options[index]!.isSelected
            ? const Icon(
                Icons.radio_button_checked_outlined,
                color: kPrimaryColor,
              )
            : const Icon(
                Icons.radio_button_off_outlined,
                color: Colors.grey,
              ),
        onTap: () {
          setState(() {
            tiers[tier]!.options[index]!.isSelected =
                !tiers[tier]!.options[index]!.isSelected;
          });
        },
      );
    }
  }
}
