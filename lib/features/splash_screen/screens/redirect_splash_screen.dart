import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/features/auth/controller/auth_controller.dart';
import 'package:morrf/features/auth/screens/signup_screen.dart';
import 'package:morrf/features/landing/screens/guest_landing_screen.dart';
import 'package:morrf/features/landing/screens/landing_screen.dart';

class RedirectSplashScreen extends ConsumerStatefulWidget {
  bool signout;
  RedirectSplashScreen({super.key, this.signout = false});

  @override
  ConsumerState<RedirectSplashScreen> createState() =>
      _RedirectSplashScreenState();
}

class _RedirectSplashScreenState extends ConsumerState<RedirectSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.signout) {
      ref.read(authControllerProvider.notifier).signout();
    }
    if (FirebaseAuth.instance.currentUser != null) {
      await Future.delayed(const Duration(seconds: 2)).then(
        (value) => Get.offAll(
          () => const LandingScreen(),
        ),
      );
    } else {
      await Future.delayed(const Duration(seconds: 2)).then(
        (value) => Get.offAll(
          () => const GuestLandingScreen(),
        ),
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "images/morrf_splash_screen.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
