import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrf/utils/auth_service.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_input_field.dart';

class ClientForgotPassword extends StatefulWidget {
  const ClientForgotPassword({Key? key}) : super(key: key);

  @override
  State<ClientForgotPassword> createState() => _ClientForgotPasswordState();
}

class _ClientForgotPasswordState extends State<ClientForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  String _email = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      return;
    }
    try {
      await AuthService().resetPassword(_email);

      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MorrfText(
              size: FontSize.p, text: error.message ?? "Something went wrong"),
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
            GestureDetector(
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
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Center(
              child: MorrfText(
                text: 'Forgot Password',
                size: FontSize.h5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: MorrfText(
                text: 'Enter you email address and we will send you code',
                size: FontSize.p,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: MorrfInputField(
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
            ),
            const Spacer(),
            SafeArea(
              child: MorrfButton(
                onPressed: () {
                  _onSubmit();
                },
                fullWidth: true,
                severity: Severity.success,
                child:
                    const MorrfText(text: 'Reset Password', size: FontSize.h5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
