import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeNotifier extends StateNotifier<ThemeMode> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getInt("darkMode");
    darkMode ??= 1;
    state = getThemeModeFromInt(darkMode);
  }

  DarkModeNotifier() : super(ThemeMode.system) {
    _init();
  }

  void toggle(int themePosition) async {
    ThemeMode currentTheme = getThemeModeFromInt(themePosition);
    state = currentTheme;
    prefs.setInt("darkMode", themePosition);
  }

  ThemeMode getThemeModeFromInt(int position) {
    switch (position) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.system;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  int getIntFromThemeMode(ThemeMode position) {
    switch (position) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.system:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 1;
    }
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, ThemeMode>(
  (ref) => DarkModeNotifier(),
);
