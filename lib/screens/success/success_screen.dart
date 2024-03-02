import 'package:ekyc/constants/app_assets.dart';
import 'package:ekyc/constants/app_strings.dart';
import 'package:ekyc/screens/failure/failure_screen.dart';
import 'package:flutter/material.dart';

import '../../common/custom_info_handler.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomInfoHandler(
        title: AppStrings.success,
        subTitle: AppStrings.YourIDCardWasSuccessfullyMatched,
        image: Assets.success,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FailureScreen(),
              ));
        },
        titleButton: AppStrings.Continue,
      ),
    );
  }
}
