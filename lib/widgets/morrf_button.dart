import 'package:flutter/material.dart';
import 'package:morrf/utils/enums/severity.dart';

class MorrfElevatedButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget child;
  final bool? fullWidth;
  final Severity? severity;
  bool? disabled;

  MorrfElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.fullWidth,
      this.disabled,
      this.severity});

  @override
  State<MorrfElevatedButton> createState() => _MorrfElevatedButtonState();
}

class _MorrfElevatedButtonState extends State<MorrfElevatedButton> {
  Color getSeverity() {
    switch (widget.severity) {
      case Severity.success:
        return Theme.of(context).buttonTheme.colorScheme!.primaryContainer;
      case Severity.danger:
        return Theme.of(context).buttonTheme.colorScheme!.errorContainer;
      case Severity.warn:
        return Theme.of(context).buttonTheme.colorScheme!.tertiaryContainer;
      default:
        return Theme.of(context).buttonTheme.colorScheme!.inversePrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize:
              widget.fullWidth != null ? const Size.fromHeight(50) : null,
          backgroundColor: getSeverity(),
          // fixedSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: widget.disabled != null && widget.disabled!
            ? null
            : widget.onPressed,
        child: widget.child);
  }
}
