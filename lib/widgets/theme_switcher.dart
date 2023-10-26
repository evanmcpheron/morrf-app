import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/providers/theme_provider.dart';
import 'package:morrf/theme/theme.dart';
import 'package:provider/provider.dart';

import 'morrf_radio.dart';

class ThemeSwitcher extends ConsumerStatefulWidget {
  const ThemeSwitcher({super.key});
  @override
  ConsumerState<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends ConsumerState<ThemeSwitcher> {
  @override
  void initState() {
    super.initState();
  }

  List<MorrfRadioButton> radios = [
    MorrfRadioButton("Light", Image.asset("images/light_mode.png")),
    MorrfRadioButton("System", Image.asset("images/system_theme.png")),
    MorrfRadioButton("Dark", Image.asset("images/dark_mode.png")),
  ];

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: MorrfRadio(
          radios: radios,
          initialValue:
              ref.read(darkModeProvider.notifier).getIntFromThemeMode(darkMode),
          onPressed: (newTheme) =>
              ref.read(darkModeProvider.notifier).toggle(newTheme)),
    ));
  }
}
