import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morrf/features/auth/screens/signin_screen.dart';
import 'package:morrf/features/auth/screens/signup_screen.dart';
import 'package:morrf/features/auth/screens/user_profile_screen.dart';
import 'package:morrf/features/payments/screens/payment_method_screen.dart';
import 'package:morrf/features/services/add_service/screens/my_services_screen.dart';
import 'package:morrf/features/settings/screens/settings_screen.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/general/menu_item.dart';

final List<Color> menuColors = [
  Colors.red,
  Colors.blue,
];

final List<MenuItem> mainSignedinProfileMenu = [
  MenuItem(
      destination:
          UserProfileScreen(userId: FirebaseAuth.instance.currentUser!.uid),
      title: "My Profile",
      icon: FontAwesomeIcons.userAstronaut),
  MenuItem(
      destination: const PaymentMethodsScreen(),
      title: "Add Payment Method",
      icon: FontAwesomeIcons.creditCard),
  MenuItem(
      destination: const SettingsScreen(),
      title: "Settings",
      icon: FontAwesomeIcons.gear),
  MenuItem(
      destination: const RedirectSplashScreen(signout: true),
      title: "Sign Out",
      icon: FontAwesomeIcons.doorOpen),
];
final List<MenuItem> mainTrainerProfileMenu = [
  MenuItem(
      destination:
          UserProfileScreen(userId: FirebaseAuth.instance.currentUser!.uid),
      title: "My Profile",
      icon: FontAwesomeIcons.userAstronaut),
  MenuItem(
      destination: const MyServicesScreen(),
      title: "Add Service",
      icon: FontAwesomeIcons.moneyBill1Wave),
  MenuItem(
      destination: const PaymentMethodsScreen(),
      title: "Add Payment Method",
      icon: FontAwesomeIcons.creditCard),
  MenuItem(
      destination: const SettingsScreen(),
      title: "Settings",
      icon: FontAwesomeIcons.gear),
  MenuItem(
      destination: const RedirectSplashScreen(signout: true),
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
