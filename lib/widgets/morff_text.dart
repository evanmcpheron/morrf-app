import 'package:flutter/material.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';

class MorrfText extends StatefulWidget {
  final String text;
  final FontSize size;
  final TextStyle? style;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isLink;
  const MorrfText(
      {super.key,
      required this.text,
      this.style,
      this.softWrap,
      this.textAlign = TextAlign.left,
      required this.size,
      this.maxLines,
      this.overflow,
      this.isLink = false});

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
      case FontSize.h6:
        return 1.1;
      case FontSize.lp:
        return 1.1;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
              fontSize: 14,
              fontWeight:
                  widget.size == FontSize.p || widget.size == FontSize.lp
                      ? FontWeight.normal
                      : FontWeight.bold,
              color: widget.isLink
                  ? Theme.of(context).colorScheme.primaryColor
                  : null)
          .apply(fontSizeFactor: getFontSize()),
      child: Text(
        widget.text,
        style: widget.style,
        softWrap: widget.softWrap,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
      ),
    );
  }
}
