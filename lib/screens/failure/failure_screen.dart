import 'package:ekyc/common/custom_info_handler.dart';
import 'package:ekyc/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInfoHandler(
      image: Assets.oops,
      title: AppStrings.oops,
      subTitle: AppStrings.YourIDCardWasNotRecognized,
      color: const Color(0xffE5734C),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There was a problem authenticating you, please redo the process')));
        Navigator.pushReplacementNamed(context, '/selfie');
      },
      titleButton: AppStrings.tryAgain,
    );
  }
}
