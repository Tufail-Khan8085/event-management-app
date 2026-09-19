import 'package:flutter/material.dart';
import '../onborarding/onboarding1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3 seconds ka timer
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F), // Red background
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 150,
        ),
      ),
    );
  }
}