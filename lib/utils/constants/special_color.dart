import 'package:flutter/material.dart';

Color money(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF33ff38)
      : const Color(0xff36a939);
}
