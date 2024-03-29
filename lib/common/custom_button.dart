import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(height: 56.w, width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? AppColors.kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r))),
          child: Text(text,
              style: CustomTextStyles.titleStyle
                  .copyWith(color: AppColors.kWhiteColor, fontSize: 18.sp)),
      ));
  }
}
