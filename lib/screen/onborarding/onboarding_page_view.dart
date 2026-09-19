import 'package:flutter/material.dart';
import 'onboarding1_screen.dart';
import 'onboarding2_screen.dart';
import 'onboarding3_screen.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        OnboardingScreen(pageController: _pageController),
        OnboardingScreen2(pageController: _pageController),
        OnboardingScreen3(pageController: _pageController),
      ],
    );
  }
}