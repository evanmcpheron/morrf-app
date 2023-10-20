// import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client_authentication/client_sign_in.dart';
import 'package:morrf/utils/auth_service.dart';
import 'package:morrf/widgets/button_global.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../widgets/constant.dart';
import '../../../widgets/icons.dart';
import 'client_otp_verification.dart';

class ClientSignUp extends StatefulWidget {
  bool isHome;
  ClientSignUp({super.key, this.isHome = false});

  @override
  State<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  bool hidePassword = true;
  bool isCheck = true;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    try {
      print(emailController.text);
      final userCredentials = await AuthService().signup(
          emailController.text,
          passwordController.text,
          nameController.text + " " + lastNameController.text);

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
        toolbarHeight: 200,
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
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Create a New Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: kInputDecoration.copyWith(
                    labelText: 'First Name',
                    hintText: 'Enter your first name',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: kInputDecoration.copyWith(
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: kInputDecoration.copyWith(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.done,
                  decoration: kInputDecoration.copyWith(
                    border: const OutlineInputBorder(),
                    labelText: 'Password*',
                    hintText: 'Please enter your password',
                    hintStyle: kTextStyle.copyWith(color: kLightNeutralColor),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: kLightNeutralColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: kPrimaryColor,
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
                      const Text("Yes, I understand and agree to the "),
                      Text(
                        "Terms of service",
                        style: kTextStyle.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )
                    ])
                  ],
                ),
                const SizedBox(height: 20.0),
                ButtonGlobalWithoutIcon(
                    buttontext: 'Sign Up',
                    buttonDecoration: kButtonDecoration.copyWith(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      // const ClientOtpVerification().launch(context);
                      print(isCheck);
                      if (isCheck) {
                        _onSubmit();
                      } else {
                        Get.snackbar(
                          "You must agree to the Terms of service",
                          "",
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 20,
                          margin: EdgeInsets.all(15),
                          duration: Duration(seconds: 4),
                          isDismissible: true,
                          forwardAnimationCurve: Curves.easeOutBack,
                        );
                      }
                    },
                    buttonTextColor: kWhite),
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
                      child: Text(
                        'Or Sign up with',
                      ),
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
                GestureDetector(
                  onTap: () => Get.to(() => ClientSignIn()),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                        ),
                        Text(
                          'Sign In',
                          style: kTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
