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

class CreateNewServiceTabTwo extends StatefulWidget {
  bool isVisible;
  CreateNewServiceTabTwo({super.key, required this.isVisible});

  @override
  State<CreateNewServiceTabTwo> createState() => _CreateNewServiceTabTwoState();
}

class _CreateNewServiceTabTwoState extends State<CreateNewServiceTabTwo> {
  //__________DeliveryTime____________________________________________________________
  DropdownButton<String> getDeliveryTime() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in deliveryTime) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: des, size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(
        FeatherIcons.chevronDown,
        size: 18,
      ),
      items: dropDownItems,
      value: selectedDeliveryTime,
      onChanged: (value) {
        setState(() {
          selectedDeliveryTime = value!;
        });
      },
    );
  }

  //__________totalScreen____________________________________________________________
  DropdownButton<String> getTotalScreen() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in pageCount) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(text: des, size: FontSize.p),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(
        FeatherIcons.chevronDown,
        size: 18,
      ),
      items: dropDownItems,
      value: selectedPageCount,
      onChanged: (value) {
        setState(() {
          selectedPageCount = value!;
        });
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        const MorrfText(
          text: 'Pricing Package',
          size: FontSize.h6,
        ),
        const SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kBorderColorTextField)),
          padding: const EdgeInsets.all(10.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(text: 'Price', size: FontSize.p),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      MorrfText(text: '5.00', size: FontSize.p),
                      SizedBox(
                        width: 30,
                      ),
                      MorrfText(text: currencySign, size: FontSize.h6),
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
                  title:
                      const MorrfText(text: 'Delivery Time', size: FontSize.p),
                  trailing:
                      DropdownButtonHideUnderline(child: getDeliveryTime()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Page/Screen',
                    size: FontSize.p,
                  ),
                  trailing:
                      DropdownButtonHideUnderline(child: getTotalScreen()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // return item
                    return Column(
                      children: [
                        titleList(
                          list[index].title,
                          list[index].isSelected,
                          index,
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: kBorderColorTextField,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kBorderColorTextField)),
          padding: const EdgeInsets.all(10.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Price',
                    size: FontSize.p,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      MorrfText(text: '30.00', size: FontSize.p),
                      SizedBox(
                        width: 30,
                      ),
                      MorrfText(text: currencySign, size: FontSize.h6),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Delivery Time',
                    size: FontSize.p,
                  ),
                  trailing:
                      DropdownButtonHideUnderline(child: getDeliveryTime()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Page/Screen',
                    size: FontSize.p,
                  ),
                  trailing:
                      DropdownButtonHideUnderline(child: getTotalScreen()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // return item
                    return Column(
                      children: [
                        titleList(
                          list[index].title,
                          list[index].isSelected,
                          index,
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: kBorderColorTextField,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kBorderColorTextField)),
          padding: const EdgeInsets.all(10.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Price',
                    size: FontSize.p,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      MorrfText(text: '60.00', size: FontSize.p),
                      SizedBox(
                        width: 30,
                      ),
                      MorrfText(text: currencySign, size: FontSize.h6),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Delivery Time',
                    size: FontSize.p,
                  ),
                  trailing:
                      DropdownButtonHideUnderline(child: getDeliveryTime()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: const MorrfText(
                    text: 'Page/Screen',
                    size: FontSize.p,
                  ),
                  trailing:
                      DropdownButtonHideUnderline(child: getTotalScreen()),
                ),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                  color: kBorderColorTextField,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // return item
                    return Column(
                      children: [
                        titleList(
                          list[index].title,
                          list[index].isSelected,
                          index,
                        ),
                        const Divider(
                          height: 0.0,
                          thickness: 1.0,
                          color: kBorderColorTextField,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    ).visible(widget.isVisible);
  }

  Widget titleList(String name, bool isSelected, int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: MorrfText(text: name, size: FontSize.p),
      trailing: isSelected
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
          list[index].isSelected = !list[index].isSelected;
        });
      },
    );
  }
}
