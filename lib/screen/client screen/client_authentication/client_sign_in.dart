import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_up.dart';
import 'package:morrf/screen/welcome%20screen/welcome_screen.dart';
import 'package:morrf/utils/auth_service.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/button_global.dart';
import '../../../widgets/constant.dart';
import '../../../widgets/icons.dart';
import '../client home/client_home.dart';
import 'client_forgot_password.dart';

class ClientSignIn extends StatefulWidget {
  bool isHome;
  ClientSignIn({super.key, this.isHome = false});

  @override
  State<ClientSignIn> createState() => _ClientSignInState();
}

class _ClientSignInState extends State<ClientSignIn> {
  bool hidePassword = false;

  final _formKey = GlobalKey<FormState>();
  var _emailKey = GlobalKey<FormFieldState>();
  var _passKey = GlobalKey<FormFieldState>();

  String _email = "";
  String _pass = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      final userCredentials = await AuthService().signin(_email, _pass);

      final User? user = FirebaseAuth.instance.currentUser;
      print(user);
      // await userCredentials.user?.sendEmailVerification();
      Get.toNamed("/");
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
                ? SizedBox()
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
                      image: AssetImage('assets/images/grey-logo.png'),
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
                      inputType: TextInputType.emailAddress,
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
                    child: const Text(
                      'Forgot Password?',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              MorrfButton(
                child: MorrfText(text: 'Sign In', size: FontSize.h5),
                fullWidth: true,
                severity: Severity.success,
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  _onSubmit();
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: const [
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
                  children: const [
                    SocialIcon(
                      bgColor: kNeutralColor,
                      iconColor: kWhite,
                      icon: FontAwesomeIcons.facebookF,
                      borderColor: Colors.transparent,
                    ),
                    SocialIcon(
                      bgColor: kWhite,
                      iconColor: kNeutralColor,
                      icon: FontAwesomeIcons.google,
                      borderColor: kBorderColorTextField,
                    ),
                    SocialIcon(
                      bgColor: kWhite,
                      iconColor: Color(0xFF76A9EA),
                      icon: FontAwesomeIcons.twitter,
                      borderColor: kBorderColorTextField,
                    ),
                    SocialIcon(
                      bgColor: kWhite,
                      iconColor: Color(0xFFFF554A),
                      icon: FontAwesomeIcons.instagram,
                      borderColor: kBorderColorTextField,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () => Get.to(() => ClientSignUp()),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      children: [
                        TextSpan(
                          text: 'Create New Account',
                          style: kTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
