// import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_in.dart';
import 'package:morrf/services/auth_service.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/icons.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';

class ClientSignUp extends ConsumerStatefulWidget {
  bool isHome;
  ClientSignUp({super.key, this.isHome = false});

  @override
  ConsumerState<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends ConsumerState<ClientSignUp> {
  bool hidePassword = true;
  bool isCheck = true;

  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _lastNameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _name = "";
  String _lastName = "";
  String _email = "";
  String _pass = "";

  void _onSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      } else {
        return;
      }
      final userCredentials =
          await AuthService().signup(_email, _pass, _name, _lastName);

      await userCredentials.user?.sendEmailVerification();

      ref.read(morrfUserProvider.notifier).getUser();
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
          child: Form(
            key: _formKey,
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
                  key: _nameKey,
                  placeholder: "First Name*",
                  hint: "Enter your First Name",
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Your first name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                MorrfInputField(
                  key: _lastNameKey,
                  placeholder: "Last Name",
                  hint: "Enter your Last Name",
                  inputType: TextInputType.name,
                  onSaved: (value) {
                    setState(() {
                      _lastName = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                MorrfInputField(
                  key: _emailKey,
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
                  inputType: TextInputType.name,
                  isSecure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
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
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: textLink(context),
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
                              ClientSignIn()), //TODO: MAKE TERMS OF SERVICE PAGE
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
                      _onSubmit();
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
                  child: const MorrfText(text: 'Sign Up', size: FontSize.h5),
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
                        iconColor: textLink(context),
                        icon: FontAwesomeIcons.facebookF,
                        borderColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      SocialIcon(
                        bgColor: Theme.of(context).colorScheme.onInverseSurface,
                        iconColor: textLink(context),
                        icon: FontAwesomeIcons.google,
                        borderColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      SocialIcon(
                        bgColor: Theme.of(context).colorScheme.onInverseSurface,
                        iconColor: textLink(context),
                        icon: FontAwesomeIcons.twitter,
                        borderColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      SocialIcon(
                        bgColor: Theme.of(context).colorScheme.onInverseSurface,
                        iconColor: textLink(context),
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
                        onTap: () => Get.to(() => ClientSignIn()),
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
