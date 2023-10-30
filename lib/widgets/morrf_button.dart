import 'package:flutter/material.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/severity.dart';

class MorrfButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget child;
  final bool? fullWidth;
  final Severity? severity;
  final double? width;
  bool? disabled;

  MorrfButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.fullWidth,
      this.width,
      this.disabled,
      this.severity});

  @override
  State<MorrfButton> createState() => _MorrfButtonState();
}

class _MorrfButtonState extends State<MorrfButton> {
  Color getSeverity() {
    switch (widget.severity) {
      case Severity.success:
        return Theme.of(context).colorScheme.successButton;
      case Severity.danger:
        return Theme.of(context).colorScheme.dangerButton;
      case Severity.warn:
        return Theme.of(context).colorScheme.warnButton;
      default:
        return Theme.of(context).colorScheme.normalButton;
    }
  }

  Color getSeverityText() {
    switch (widget.severity) {
      case Severity.success:
        return Theme.of(context).colorScheme.successButton;
      case Severity.danger:
        return Colors.black;
      case Severity.warn:
        return Theme.of(context).colorScheme.warnButton;
      default:
        return Theme.of(context).colorScheme.normalButton;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          child: widget.child),
    );
  }
}
