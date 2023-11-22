import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:morrf/providers/theme_provider.dart';
import 'package:morrf/providers/user_provider.dart';
import 'utils/constants/routes.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51IX81QIoSCTAdjFzUxCtBoNLq0ursYjNVqdp8jry8NjXClD0a1Gkl010mmvvPIqaXNq9o45T62iYMzhngaONI7dR00k7A1JK8u";
  Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    Adapty().activate();
  } on AdaptyError catch (adaptyError) {
    print(adaptyError);
  }

  final lightThemeStr = await rootBundle.loadString('assets/light_theme.json');
  final lightThemeJson = jsonDecode(lightThemeStr);
  final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson)!;
  final darkThemeStr = await rootBundle.loadString('assets/dark_theme.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  return runApp(ProviderScope(
      child: MyApp(darkTheme: darkTheme, lightTheme: lightTheme)));
}

class MyApp extends ConsumerStatefulWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({super.key, required this.lightTheme, required this.darkTheme});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // seedServices();
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    ref.read(morrfUserProvider.notifier).getCurrentUser();

    return GetMaterialApp(
      title: 'Morrf',
      defaultTransition: Transition.noTransition,
      initialRoute: "/",
      themeMode: darkMode,
      darkTheme: widget.darkTheme,
      theme: widget.lightTheme,
      getPages: routes,
    );
    ;
  }
}
