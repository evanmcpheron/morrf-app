import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/core/widgets/error.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/core/widgets/morrf_scaffold.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/become_trainer_screen.dart';
import 'package:morrf/features/splash_screen/screens/splash_screen.dart';
import 'package:morrf/models/user/morrf_user.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  String? userId;
  UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignedInUser = widget.userId == null;
    MorrfUser morrfUser = ref.watch(authControllerProvider);

    return MorrfScaffold(
      title: isSignedInUser ? "My Profile" : "Someone Else",
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Text("Testing"),
            ),
            isSignedInUser && morrfUser?.morrfTrainer == null
                ? MorrfButton(
                    onPressed: () => Get.to(() => const BecomeTrainerScreen()),
                    fullWidth: true,
                    text: "Become a Morrf Trainer",
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
