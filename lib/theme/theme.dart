import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late int _themeModePosition = 1;

  ThemeMode get themeMode => getThemeModeFromInt(_themeModePosition);

  ThemeNotifier() {
    _loadFromPrefs();
  }

  toggleTheme(int newTheme) async {
    _themeModePosition = newTheme;

    _saveToPrefs(newTheme);
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("themeMode") == null) {
      _saveToPrefs(1);
      return;
    }
    _themeModePosition = prefs.getInt("themeMode")!;
    notifyListeners();
  }

  Future<void> _saveToPrefs(int themePosition) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("themeMode", themePosition);
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

  int getIntFromThemeMode(ThemeMode theme) {
    switch (theme) {
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

enum ThemeModesEnum {
  dark(ThemeMode.dark),
  light(ThemeMode.light),
  system(ThemeMode.system);

  const ThemeModesEnum(this.mode);
  final ThemeMode mode;
}
