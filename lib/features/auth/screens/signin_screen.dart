import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/utils.dart';
import 'package:morrf/core/widgets/icons.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_input_field.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .signinWithEmailAndPassword(context, email, password);
    } else {
      showSnackBar(context, 'Fill out all the fields');
    }
  }

  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "",
      body: Center(
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
              Column(
                children: [
                  MorrfInputField(
                    placeholder: "Email",
                    hint: "Enter your email",
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  MorrfInputField(
                    placeholder: "Password*",
                    hint: "Enter your password",
                    inputType: TextInputType.text,
                    isSecure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Enter a password longer than 6 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => print("Go to forgot password"),
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
                onPressed: onSubmit,
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
                      iconColor: Theme.of(context).colorScheme.primary,
                      icon: FontAwesomeIcons.facebookF,
                      borderColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SocialIcon(
                      bgColor: Theme.of(context).colorScheme.onInverseSurface,
                      iconColor: Theme.of(context).colorScheme.primary,
                      icon: FontAwesomeIcons.google,
                      borderColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    SocialIcon(
                      bgColor: Theme.of(context).colorScheme.onInverseSurface,
                      iconColor: Theme.of(context).colorScheme.primary,
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
                      onTap: () => Get.to(() => const SignupScreen()),
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
