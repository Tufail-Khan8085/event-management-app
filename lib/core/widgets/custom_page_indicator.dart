import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/app_colors.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const CustomPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        expansionFactor: 3,
        spacing: 8,
        activeDotColor: AppColors.primary,
        dotColor: Colors.grey,
      ),
    );
  }
}