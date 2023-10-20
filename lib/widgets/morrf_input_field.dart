import 'package:flutter/material.dart';

class MorrfInputField extends StatefulWidget {
  final String placeholder;
  final String? hint;
  final bool isSecure;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final bool? isFilled;
  final Color? fillColor;
  final bool? enabled;
  final void Function()? clear;
  final void Function()? onTap;
  final String? initialValue;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;

  const MorrfInputField(
      {super.key,
      required this.placeholder,
      this.isSecure = false,
      this.onTap,
      this.hint,
      this.inputType,
      this.validator,
      this.isFilled = true,
      this.fillColor,
      this.clear,
      this.prefixIcon,
      this.onSaved,
      this.enabled,
      this.initialValue});

  @override
  State<MorrfInputField> createState() => _MorrfInputFieldState();
}

class _MorrfInputFieldState extends State<MorrfInputField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Widget? getSuffixIcon() {
    if (widget.clear != null) {
      return IconButton(
        onPressed: () => {widget.clear!(), setState(() {})},
        icon: const Icon(Icons.clear),
      );
    } else if (widget.isSecure) {
      return IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      );
    }
    return null;
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
      child: TextFormField(
        enabled: widget.enabled,
        keyboardType: widget.inputType,
        validator: widget.validator,
        onSaved: widget.onSaved,
        textInputAction: TextInputAction.done,
        onTap: widget.onTap,
        initialValue: widget.initialValue,
        obscureText: widget.isSecure &&
            !_passwordVisible, //This will obscure text dynamically
        decoration: InputDecoration(
          labelText: widget.placeholder,
          hintText: widget.hint ?? widget.placeholder,
          filled: widget.isFilled,
          fillColor: widget.fillColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor(context), width: 2.0),
          ),
          suffixIcon: getSuffixIcon(),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.prefixIcon,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor(context), width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: borderColor(context), width: 2.0),
          ),
        ),
      ),
    );
  }
}
