import 'dart:convert';

import 'package:ekyc/database/cache/cache_helper.dart';
import 'package:ekyc/services/service_locator.dart';
import 'package:flutter/material.dart';

import '../../common/custom_info_handler.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../failure/failure_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var ocrData = jsonDecode(getIt<CacheHelper>().getDataString(key: 'ocrData')!);
    var deepfaceData = getIt<CacheHelper>().getData(key: 'deepfaceData');
    return CustomInfoHandler(
      title: AppStrings.success,
      subTitle: "National ID: ${ocrData['national_id']}, Issuing Date: ${ocrData['issuing_date']}, Expiry Date: ${ocrData['expiry_date']}, Face Matched: ${deepfaceData.toString()}",
      image: Assets.success,
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/profile');

      },
      titleButton: AppStrings.Continue,
    );
  }
}
