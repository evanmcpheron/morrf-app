import 'package:flutter/material.dart';
import 'package:morrf/utils/enums/font_size.dart';

class MorrfText extends StatefulWidget {
  final String text;
  final FontSize size;
  final TextStyle? style;
  final bool? softWrap;
  final TextAlign? textAlign;
  const MorrfText(
      {super.key,
      required this.text,
      this.style,
      this.softWrap,
      this.textAlign = TextAlign.left,
      required this.size});

  @override
  State<MorrfText> createState() => _MorrfTextState();
}

class _MorrfTextState extends State<MorrfText> {
  double getFontSize() {
    switch (widget.size) {
      case FontSize.h1:
        return 2.0;
      case FontSize.h2:
        return 1.8;
      case FontSize.h3:
        return 1.6;
      case FontSize.h4:
        return 1.4;
      case FontSize.h5:
        return 1.2;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.size == FontSize.p) {
      return DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)
            .apply(fontSizeFactor: getFontSize()),
        child: Text(
          widget.text,
          style: widget.style,
          softWrap: widget.softWrap,
          textAlign: widget.textAlign,
        ),
      );
    } else {
      return DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            .apply(fontSizeFactor: getFontSize()),
        child: Text(
          widget.text,
          style: widget.style,
          softWrap: widget.softWrap,
          textAlign: widget.textAlign,
        ),
      );
    }
  }
}
