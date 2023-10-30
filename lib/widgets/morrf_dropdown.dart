import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morrf/utils/constants/special_color.dart';

class MorrfDrowpdown extends StatefulWidget {
  List<String> list;
  String selected;
  String label;
  String? initialValue;
  Function(String) onChange;
  MorrfDrowpdown({
    super.key,
    required this.selected,
    required this.label,
    required this.list,
    this.initialValue,
    required this.onChange,
  });

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
    return FormField(
      initialValue: widget.initialValue ?? widget.list[0],
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: InputDecoration(
            filled: true,
            constraints: const BoxConstraints(maxHeight: 56),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.borderColor, width: 2.0),
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
                  color: Theme.of(context).colorScheme.borderColor, width: 2.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
              child: getSelectedItem(widget.selected)),
        );
      },
    );
  }
}
