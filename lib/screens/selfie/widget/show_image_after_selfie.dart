import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';

import '../../../common/custom_button.dart';
import '../../../constants/app_strings.dart';
import '../../../database/cache/cache_helper.dart';
import '../../../services/service_locator.dart';

class ShowImageAfterSelfie extends StatelessWidget {
  const ShowImageAfterSelfie({super.key, required this.imageLivePath});
  final String? imageLivePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Image.file(
                File(imageLivePath ?? ""),
                fit: BoxFit.contain,
              ).widthAndHeight(
                width: 400.h,
                height: 400.w,
              ),
              SizedBox(
                height: 200.h,
              ),
              CustomButton(
                onPressed: () {
                  getIt<CacheHelper>()
                      .saveData(key: 'live_image', value: imageLivePath);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                text: AppStrings.Continue,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/selfie', (route) => false);
                },
                child: const Text(AppStrings.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
