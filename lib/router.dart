import 'dart:io';

import 'package:flutter/material.dart';
import 'package:morrf/core/widgets/error.dart';
import 'package:morrf/features/auth/screens/signin_screen.dart';
import 'package:morrf/features/auth/screens/signup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SigninScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      );
    case SignupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
