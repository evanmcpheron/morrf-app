import 'package:flutter/material.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';

class MorrfButton extends StatefulWidget {
  final void Function() onPressed;
  final bool? fullWidth;
  final String text;
  final Severity? severity;
  final double? width;
  bool? disabled;

  MorrfButton(
      {super.key,
      required this.onPressed,
      this.fullWidth,
      this.width,
      this.disabled,
      this.severity,
      required this.text});

  @override
  State<MorrfButton> createState() => _MorrfButtonState();
}

class _MorrfButtonState extends State<MorrfButton> {
  Color getSeverity() {
    switch (widget.severity) {
      case Severity.success:
        return Theme.of(context).colorScheme.primary;
      case Severity.danger:
        return Theme.of(context).colorScheme.error;
      case Severity.warn:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.text);
    return Theme(
      data: ThemeData(buttonTheme: const ButtonThemeData()),
      child: SizedBox(
        width: widget.fullWidth != null
            ? MediaQuery.of(context).size.width
            : widget.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
              backgroundColor: getSeverity(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: widget.disabled != null && widget.disabled!
                ? null
                : widget.onPressed,
            child: MorrfText(
              text: widget.text,
              size: FontSize.h6,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            )),
      ),
    );
  }
}
