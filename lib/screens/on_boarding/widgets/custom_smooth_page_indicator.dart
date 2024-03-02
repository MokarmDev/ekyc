import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_colors.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const CustomSmoothPageIndicator(
      {super.key, required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller, // PageController
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.kYellowColor,
        dotHeight: 7,
        dotWidth: 10,
      ), // your preferred effect
    );
  }
}
