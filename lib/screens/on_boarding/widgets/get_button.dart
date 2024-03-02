import 'package:flutter/material.dart';

import '../../../common/custom_button.dart';
import '../../../constants/app_strings.dart';
import '../../../functions/is_on_boarding_visited.dart';
import '../data/on_boarding_model.dart';

class GetButton extends StatelessWidget {
  final PageController controller;
  final int currentIndex;

  const GetButton(
      {super.key, required this.controller, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingData.length - 1) {
      return Column(
        children: [
          CustomButton(
              onPressed: () {
                isOnBoardingVisited();
                Navigator.of(context).pushReplacementNamed('/selfie');
              },
              text: AppStrings.start),
        ],
      );
    } else {
      return CustomButton(
        text: AppStrings.next,
        onPressed: () {
          controller.nextPage(
              duration: const Duration(microseconds: 200),
              curve: Curves.bounceIn);
        },
      );
    }
  }
}
