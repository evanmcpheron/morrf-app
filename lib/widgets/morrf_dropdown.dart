import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MorrfDrowpdown extends StatefulWidget {
  const MorrfDrowpdown({
    super.key,
  });

  @override
  State<MorrfDrowpdown> createState() => _MorrfDrowpdownState();
}

class _MorrfDrowpdownState extends State<MorrfDrowpdown> {
  bool _passwordVisible = false;
  String _selectedGender = "";

  @override
  void initState() {
    super.initState();
  }

  List<String> list = ["Test", "Another", "last"];

  DropdownButton<String> getGender() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in list) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: _selectedGender,
      // value: _selectedGender == "" ? selectedGender : _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF144185)
        : const Color(0xff216dde);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: FormField(
        builder: (FormFieldState<dynamic> field) {
          return InputDecorator(
            decoration: InputDecoration(
              filled: true,
              constraints: const BoxConstraints(maxHeight: 56),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor(context), width: 2.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: borderColor(context), width: 2.0),
              ),
            ),
            child: DropdownButtonHideUnderline(child: getGender()),
          );
        },
      ),
    );
  }
}
