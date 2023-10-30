import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client_screen/client_authentication/client_sign_up.dart';
import 'package:morrf/services/auth_service.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/icons.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';
import 'package:nb_utils/nb_utils.dart';

import 'client_forgot_password.dart';

class ClientConfirmSignIn extends StatefulWidget {
  bool isHome;
  ClientConfirmSignIn({super.key, this.isHome = false});

  @override
  State<ClientConfirmSignIn> createState() => _ClientConfirmSignInState();
}

class _ClientConfirmSignInState extends State<ClientConfirmSignIn> {
  bool hidePassword = false;
  User user = FirebaseAuth.instance.currentUser!;

  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _pass = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      await AuthService().signin(user.email!, _pass);
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
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

  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Center(
              child: MorrfText(
                text: 'Confirm your password to update.',
                size: FontSize.h5,
              ),
            ),
            const SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MorrfInputField(
                    key: _passKey,
                    placeholder: "Password*",
                    hint: "Enter your password",
                    inputType: TextInputType.emailAddress,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: buildContent(context),
      actions: [
        MorrfButton(
          severity: Severity.success,
          child: const Text('Confirm'),
          onPressed: () {
            _onSubmit();
          },
        ),
        MorrfButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}
