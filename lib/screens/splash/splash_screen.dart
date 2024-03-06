import 'dart:async';

import 'package:ekyc/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () async {
        await Navigator.pushReplacementNamed(context, '/onBoarding');
      },
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
      height: 500,
            child: SvgPicture.asset(
              Assets.splashOne,
            ),
          ),

          Expanded(
            child: Text(
              AppStrings.appName,
              style: CustomTextStyles.logoStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              Assets.splashTwo,
            ),
          ),
        ],
      ),
    );
  }
}
