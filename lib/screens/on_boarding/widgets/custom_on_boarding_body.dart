import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';

import '../../../constants/app_text_styles.dart';
import '../data/on_boarding_model.dart';
import 'custom_smooth_page_indicator.dart';

class CustomOnBoardingBody extends StatelessWidget {
  final PageController controller;
  final Function(int)? onPageChanged;
  const CustomOnBoardingBody(
      {super.key, required this.controller, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      itemCount: onBoardingData.length,
      controller: controller,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              onBoardingData[index].imagePath,
              height: 300.h,
              width: 300.w,
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomSmoothPageIndicator(
              controller: controller,
              count: 4,
            ),
            SizedBox(
              height: 100.h,
            ),
            Text(
              onBoardingData[index].title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    ).withHeight(700);
  }
}
