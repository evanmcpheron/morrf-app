import 'package:flutter/material.dart';
import 'package:morrf/theme/theme.dart';
import 'package:provider/provider.dart';

import 'morrf_radio.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});
  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  void initState() {
    super.initState();
  }

  List<MorrfRadioButton> radios = [
    MorrfRadioButton("Light", Image.asset("assets/images/light_mode.png")),
    MorrfRadioButton("System", Image.asset("assets/images/system_theme.png")),
    MorrfRadioButton("Dark", Image.asset("assets/images/dark_mode.png")),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => MorrfRadio(
            radios: radios,
            initialValue: notifier.getIntFromThemeMode(notifier.themeMode),
            onPressed: (newTheme) => notifier.toggleTheme(newTheme)),
      ),
    ));
  }
}
