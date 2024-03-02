import 'package:flutter/material.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Function() onPressed;
  final String text;

  const CustomButton(
      {super.key, this.color, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(text,
          style: CustomTextStyles.titleStyle
              .copyWith(color: AppColors.kWhiteColor, fontSize: 18)),
    ).widthAndHeight(width: double.infinity, height: 56);
  }
}
