import 'package:ekyc/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';

import '../constants/app_text_styles.dart';
import 'custom_button.dart';

class CustomInfoHandler extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String titleButton;
  final Color? color;
  final Function() onPressed;

  const CustomInfoHandler(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      required this.titleButton,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                Assets.clip,
              )),
          Column(
            children: [
              180.height,
              Image.asset(
                image,
                height: 270,
                width: 270,
              ),
              20.height,
              Text(
                title,
                style: CustomTextStyles.titleStyle
                    .copyWith(fontSize: 30, color: color),
              ),
              Text(
                subTitle,
                style: CustomTextStyles.smallText.copyWith(
                  color: color,
                ),
              ),
            ],
          ).center(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onPressed: onPressed,
                  text: titleButton,
                  color: color,
                )),
          ),
        ],
      ),
    );
  }
}
