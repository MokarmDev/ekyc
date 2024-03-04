import 'package:ekyc/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';
import 'package:m7_livelyness_detection/index.dart';

import '../constants/app_text_styles.dart';
import 'custom_button.dart';

class CustomInfoHandler extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String titleButton;
  final Color? color;
  final Function() onPressed;

  const CustomInfoHandler({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.titleButton,
    this.color,
  });

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
                height: 270.h,
                width: 270.w,
              ),
              20.height,
              Text(
                title,
                style: CustomTextStyles.titleStyle
                    .copyWith(fontSize: 30.sp, color: color),
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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
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
