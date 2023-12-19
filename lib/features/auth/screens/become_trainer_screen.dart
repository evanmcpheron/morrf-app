import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/landing/screens/landing_screen.dart';

class BecomeTrainerScreen extends ConsumerStatefulWidget {
  const BecomeTrainerScreen({super.key});

  @override
  ConsumerState<BecomeTrainerScreen> createState() =>
      _BecomeTrainerScreenState();
}

class _BecomeTrainerScreenState extends ConsumerState<BecomeTrainerScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
  }

  void becomeTrainer() async {
    ref.read(authControllerProvider.notifier).becomeTrainer();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailVerified = !FirebaseAuth.instance.currentUser!.emailVerified;
    return MorrfScaffold(
        title: "Become a Trainer",
        body: Column(
          children: [
            const SizedBox(height: 8),
            const VerifyEmail(),
            isEmailVerified ? const SizedBox(height: 16.0) : const SizedBox(),
            isEmailVerified ? const SizedBox(height: 16.0) : const SizedBox(),
            isEmailVerified ? const Divider() : const SizedBox(),
            isEmailVerified
                ? const MorrfText(text: "Become a Trainer", size: FontSize.h5)
                : const SizedBox(),
            const SizedBox(height: 16.0),
            const MorrfText(
                text:
                    "We want to extend our heartfelt gratitude to you for expressing your interest in becoming a Morrf trainer. Your dedication to helping others on their path to a healthier life is truly inspiring. At Morrf, we hold safety and the delivery of top-notch services in the highest regard. By clicking \"Become a Morrf Trainer,\" you are making a personal commitment to prioritize the best health practices for your clients.",
                size: FontSize.p),
            const SizedBox(height: 16.0),
            const MorrfText(
                text:
                    "Your passion and enthusiasm mean the world to us, and we're excited to have you as part of the Morrf family. Together, we'll make a real difference in people's lives, fostering wellness and well-being. Thank you for choosing to be a part of this incredible journey.",
                size: FontSize.p),
            const SizedBox(height: 16.0),
            MorrfButton(
                onPressed: () => becomeTrainer(),
                text: "Become a Trainer",
                fullWidth: true,
                disabled: isEmailVerified),
            const Spacer(),
            SafeArea(
              child: MorrfButton(
                  onPressed: () => Get.offAll(() => const LandingScreen()),
                  text: "Go back to shopping",
                  fullWidth: true),
            ),
          ],
        ));
  }
}

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool clickedResend = false;
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;

    return !user.emailVerified
        ? Column(
            children: [
              const MorrfText(text: "Verify Your Email", size: FontSize.h5),
              const SizedBox(height: 16.0),
              const MorrfText(
                  text:
                      "To kickstart your journey as a Morrf trainer, we kindly ask you to verify your email. If you ever need to have the verification link resent, simply click the button below. After verifying your email, please exit the app and relaunch it to continue becoming a Morrf trainer.",
                  size: FontSize.p),
              const SizedBox(height: 16.0),
              clickedResend
                  ? const MorrfText(
                      text: "Sending verification email now...",
                      size: FontSize.p)
                  : MorrfButton(
                      onPressed: () {
                        user.sendEmailVerification();
                        setState(() {
                          clickedResend = true;
                        });
                      },
                      severity: Severity.danger,
                      fullWidth: true,
                      text: "Send Verification Link",
                    ),
            ],
          )
        : const SizedBox();
  }
}
