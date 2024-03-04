import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class CustomTextStyles {
  static final logoStyle = TextStyle(
    color: AppColors.kDeepBlue,
    fontWeight: FontWeight.w400,
    fontSize: 25.sp,
  );
  static final titleStyle = TextStyle(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );
  static final smallText = TextStyle(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );
}
