import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/enums/severity.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:uuid/uuid.dart';

class TrainerStarterHome extends ConsumerStatefulWidget {
  const TrainerStarterHome({super.key});

  @override
  ConsumerState<TrainerStarterHome> createState() => _TrainerStarterHomeState();
}

class _TrainerStarterHomeState extends ConsumerState<TrainerStarterHome> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      print(user.emailVerified);
      if (user.emailVerified &&
          ref.watch(morrfUserProvider).morrfTrainer != null) {
        Get.offAll(() => TrainerHome());
      }
    });
  }

  void becomeTrainer() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        'morrfTrainer': {
          'id': const Uuid().v4(),
          'services': [],
          'ratings': [],
          'orders': []
        }
      }).then((value) {
        Get.offAll(() => TrainerHome());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailVerified = !FirebaseAuth.instance.currentUser!.emailVerified;
    return MorrfScaffold(
        title: "Become a Trainer",
        body: Column(
          children: [
            SizedBox(height: MorrfSize.m.size),
            const VerifyEmail(),
            isEmailVerified
                ? SizedBox(height: MorrfSize.m.size)
                : const SizedBox(),
            isEmailVerified
                ? SizedBox(height: MorrfSize.m.size)
                : const SizedBox(),
            isEmailVerified ? const Divider() : const SizedBox(),
            isEmailVerified
                ? const MorrfText(text: "Become a Trainer", size: FontSize.h5)
                : const SizedBox(),
            SizedBox(height: MorrfSize.m.size),
            const MorrfText(
                text:
                    "We want to extend our heartfelt gratitude to you for expressing your interest in becoming a Morrf trainer. Your dedication to helping others on their path to a healthier life is truly inspiring. At Morrf, we hold safety and the delivery of top-notch services in the highest regard. By clicking \"Become a Morrf Trainer,\" you are making a personal commitment to prioritize the best health practices for your clients.",
                size: FontSize.p),
            SizedBox(height: MorrfSize.m.size),
            const MorrfText(
                text:
                    "Your passion and enthusiasm mean the world to us, and we're excited to have you as part of the Morrf family. Together, we'll make a real difference in people's lives, fostering wellness and well-being. Thank you for choosing to be a part of this incredible journey.",
                size: FontSize.p),
            SizedBox(height: MorrfSize.m.size),
            MorrfButton(
                onPressed: () => becomeTrainer(),
                text: "Become a Trainer",
                fullWidth: true,
                disabled: isEmailVerified),
            const Spacer(),
            SafeArea(
              child: MorrfButton(
                  onPressed: () => Get.offAll(() => ClientHome()),
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
              SizedBox(height: MorrfSize.m.size),
              const MorrfText(
                  text:
                      "To kickstart your journey as a Morrf trainer, we kindly ask you to verify your email. If you ever need to have the verification link resent, simply click the button below. After verifying your email, please exit the app and relaunch it to continue becoming a Morrf trainer.",
                  size: FontSize.p),
              SizedBox(height: MorrfSize.m.size),
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
