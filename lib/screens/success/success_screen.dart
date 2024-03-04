import 'package:flutter/material.dart';

import '../../common/custom_info_handler.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../failure/failure_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInfoHandler(
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
    );
  }
}
