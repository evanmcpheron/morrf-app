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
import 'package:morrf/features/auth/screens/signin_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const routeName = '/signup-screen';
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isCheck = false;

  void onSubmit() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .signupWithEmailAndPassword(context, email, password);
    } else {
      showSnackBar(context, 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "",
      body: Center(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: MorrfText(
                    text: 'Create a New Account',
                    size: FontSize.h5,
                  ),
                ),
                const SizedBox(height: 20.0),
                MorrfInputField(
                  controller: emailController,
                  placeholder: "Email*",
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
                ),
                const SizedBox(height: 20.0),
                MorrfInputField(
                  controller: passwordController,
                  placeholder: "Password*",
                  hint: "Enter your password",
                  inputType: TextInputType.name,
                  isSecure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Enter a password longer than 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                MorrfInputField(
                  controller: confirmPasswordController,
                  placeholder: "Confirm Password*",
                  hint: "Confirm your password",
                  inputType: TextInputType.name,
                  isSecure: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value != passwordController.text) {
                      return 'Make sure your passwords match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: Theme.of(context).colorScheme.primary,
                        visualDensity: const VisualDensity(horizontal: -4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        value: isCheck,
                        onChanged: (value) {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        }),
                    Row(children: [
                      const MorrfText(
                          text: "Yes, I understand and agree to the ",
                          size: FontSize.p),
                      GestureDetector(
                          onTap: () => Get.to(() =>
                              const SigninScreen()), //TODO: MAKE TERMS OF SERVICE PAGE
                          child: const MorrfText(
                            text: "Terms of service",
                            size: FontSize.h6,
                            isLink: true,
                          )),
                    ])
                  ],
                ),
                const SizedBox(height: 20.0),
                MorrfButton(
                  fullWidth: true,
                  severity: Severity.success,
                  onPressed: () {
                    // const ClientOtpVerification().launch(context);
                    if (isCheck) {
                      onSubmit();
                    } else {
                      Get.snackbar(
                        "You must agree to the Terms of service",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 20,
                        margin: const EdgeInsets.all(15),
                        duration: const Duration(seconds: 4),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    }
                  },
                  text: 'Sign Up',
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
                      child:
                          MorrfText(text: 'Or Sign up with', size: FontSize.p),
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
                          text: "Already have an account? ", size: FontSize.p),
                      GestureDetector(
                        onTap: () => Get.to(() => const SigninScreen()),
                        child: const MorrfText(
                          text: "Sign In",
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
      ),
    );
  }
}
