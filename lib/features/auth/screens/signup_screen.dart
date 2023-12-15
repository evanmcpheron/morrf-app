import 'package:flutter/material.dart';
import 'package:morrf/features/auth/screens/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void navigateToSigninScreen(BuildContext context) {
    Navigator.pushNamed(context, SigninScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
