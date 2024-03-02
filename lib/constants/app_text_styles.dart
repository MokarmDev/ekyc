import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class CustomTextStyles {
  static final logoStyle = TextStyle(
    color: AppColors.kDeepBlue,
    fontWeight: FontWeight.w400,
    fontSize: 25,
  );
  static final titleStyle = TextStyle(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static final smallText = TextStyle(
    color: AppColors.kSecondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
