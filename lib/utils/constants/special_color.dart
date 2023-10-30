import 'package:flutter/material.dart';

extension CustomColors on ColorScheme {
  Color get borderColor => brightness == Brightness.dark
      ? const Color(0xFF144185)
      : const Color(0xff216dde);

  Color get textLink => brightness == Brightness.dark
      ? const Color(0xFF216dde)
      : const Color(0xff216dde);

  Color get money => brightness == Brightness.dark
      ? const Color(0xFF33ff38)
      : const Color(0xff36a939);

  Color get dangerButton => brightness == Brightness.dark
      ? const Color(0xFFd32f2f)
      : const Color(0xffe57373);

  Color get successButton => brightness == Brightness.dark
      ? const Color(0xFF81c784)
      : const Color(0xff388e3c);

  Color get warnButton => brightness == Brightness.dark
      ? const Color(0xFFf57c00)
      : const Color(0xffffb74d);

  Color get normalButton => brightness == Brightness.dark
      ? const Color(0xFFab47bc)
      : const Color(0xffce93d8);
}
