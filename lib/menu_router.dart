import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/features/auth/screens/signin_screen.dart';
import 'package:morrf/features/auth/screens/signup_screen.dart';
import 'package:morrf/features/auth/screens/user_profile_screen.dart';
import 'package:morrf/features/settings/screens/settings_screen.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/general/menu_item.dart';

final List<Color> menuColors = [
  Colors.red,
  Colors.blue,
];

final List<MenuItem> mainSignedinProfileMenu = [
  MenuItem(
      destination: UserProfileScreen(),
      title: "My Profile",
      icon: FontAwesomeIcons.userAstronaut),
  MenuItem(
      destination: const Text(""),
      title: "Add Payment Method",
      icon: FontAwesomeIcons.creditCard),
  MenuItem(
      destination: const SettingsScreen(),
      title: "Settings",
      icon: FontAwesomeIcons.gear),
  MenuItem(
      destination: RedirectSplashScreen(signout: true),
      title: "Sign Out",
      icon: FontAwesomeIcons.doorOpen),
];
final List<MenuItem> mainGuestProfileMenu = [
  MenuItem(
      destination: const SettingsScreen(),
      title: "Settings",
      icon: FontAwesomeIcons.gear),
  MenuItem(
      destination: const SigninScreen(),
      title: "Sign In",
      icon: FontAwesomeIcons.doorOpen),
  MenuItem(
      destination: const SignupScreen(),
      title: "Sign Up",
      icon: FontAwesomeIcons.userPlus),
];
