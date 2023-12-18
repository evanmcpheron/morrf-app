import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final Widget destination;
  final IconData icon;

  MenuItem(
      {required this.title, required this.destination, required this.icon});
}
