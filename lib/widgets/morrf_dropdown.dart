import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';

class MorrfDrowpdown extends StatefulWidget {
  List<String> list;
  String selected;
  String label;
  String? initialValue;
  bool compact;
  Function(String) onChange;
  MorrfDrowpdown(
      {super.key,
      required this.selected,
      required this.label,
      required this.list,
      this.initialValue,
      required this.onChange,
      this.compact = false});

  @override
  State<MorrfDrowpdown> createState() => _MorrfDrowpdownState();
}

class _MorrfDrowpdownState extends State<MorrfDrowpdown> {
  String _selectedItem = "";

  @override
  void initState() {
    super.initState();
  }

  DropdownButton<String> getSelectedItem(String? selectedItem) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in widget.list) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: _selectedItem == "" ? selectedItem : _selectedItem,
      onChanged: (value) {
        setState(() {
          _selectedItem = value!;
          widget.onChange(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.compact) {
      return FormField(
        initialValue: widget.initialValue ?? widget.list[0],
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: InputDecoration(
              filled: true,
              constraints: const BoxConstraints(maxHeight: 56),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryColor
                        .withOpacity(.5),
                    width: 2.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              labelText: widget.label,
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryColor
                        .withOpacity(.5),
                    width: 2.0),
              ),
            ),
            child: DropdownButtonHideUnderline(
                child: getSelectedItem(widget.selected)),
          );
        },
      );
    } else {
      return SizedBox(
        height: 35,
        width: 150,
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.primaryColor.withOpacity(.5)),
          ),
          child: DropdownButtonHideUnderline(
            child: getSelectedItem(widget.selected),
          ),
        ),
      );
    }
  }

  DropdownButton<String> getPerformancePeriod() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in period) {
      var item = DropdownMenuItem(
        value: des,
        child: MorrfText(
          text: des,
          size: FontSize.p,
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedPeriod,
      onChanged: (value) {
        setState(() {
          selectedPeriod = value!;
        });
      },
    );
  }
}
