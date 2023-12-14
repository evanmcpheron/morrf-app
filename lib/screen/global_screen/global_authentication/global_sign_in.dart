import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/global_screen/global_authentication/global_sign_up.dart';
import 'package:morrf/screen/global_screen/splash_screen/mt_splash_screen.dart';
import 'package:morrf/services/auth_service.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/icons.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';

import 'global_forgot_password.dart';

class ClientSignIn extends ConsumerStatefulWidget {
  bool isHome;
  ClientSignIn({super.key, this.isHome = false});

  @override
  ConsumerState<ClientSignIn> createState() => _ClientSignInState();
}

class _ClientSignInState extends ConsumerState<ClientSignIn> {
  bool hidePassword = false;

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _email = "";
  String _pass = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      await AuthService().signin(_email, _pass);
      ref.read(morrfUserProvider.notifier).getCurrentUser();
      Get.to(() => const SplashScreen());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MorrfText(
              size: FontSize.p,
              text: error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        toolbarHeight: 180,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isHome
                ? const SizedBox()
                : GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
            Center(
              child: Container(
                height: 100,
                width: 85,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/grey-logo.png'),
                      fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              const Center(
                child: MorrfText(
                  text: 'Sign In Your Account',
                  size: FontSize.h5,
                ),
              ),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MorrfInputField(
                      key: _emailKey,
                      placeholder: "Email",
                      hint: "Enter your email",
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _email = value.toString();
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    MorrfInputField(
                      key: _passKey,
                      placeholder: "Password*",
                      hint: "Enter your password",
                      inputType: TextInputType.text,
                      isSecure: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Enter a password longer than 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _pass = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => const ClientForgotPassword().launch(context),
                    child: const MorrfText(
                        text: 'Forgot Password?',
                        textAlign: TextAlign.end,
                        isLink: true,
                        size: FontSize.p),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              MorrfButton(
                fullWidth: true,
                severity: Severity.success,
                onPressed: () {
                  _onSubmit();
                },
                text: 'Sign In',
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: MorrfText(text: 'Or Sign up with', size: FontSize.p),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialIcon(
                      bgColor: Theme.of(context).colorScheme.onInverseSurface,
                      iconColor: Theme.of(context).colorScheme.primaryColor,
                      icon: FontAwesomeIcons.facebookF,
                      borderColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SocialIcon(
                      bgColor: Theme.of(context).colorScheme.onInverseSurface,
                      iconColor: Theme.of(context).colorScheme.primaryColor,
                      icon: FontAwesomeIcons.google,
                      borderColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SocialIcon(
                      bgColor: Theme.of(context).colorScheme.onInverseSurface,
                      iconColor: Theme.of(context).colorScheme.primaryColor,
                      icon: FontAwesomeIcons.instagram,
                      borderColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MorrfText(
                        text: "Don't have an account? ", size: FontSize.p),
                    GestureDetector(
                      onTap: () => Get.to(() => ClientSignUp()),
                      child: const MorrfText(
                        text: "Sign Up",
                        size: FontSize.h6,
                        isLink: true,
                      ),
                    ),
                    const MorrfText(text: ".", size: FontSize.p),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
