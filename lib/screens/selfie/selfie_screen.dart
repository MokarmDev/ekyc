import 'package:ekyc/common/custom_info_handler.dart';
import 'package:ekyc/constants/app_assets.dart';
import 'package:ekyc/constants/app_strings.dart';
import 'package:m7_livelyness_detection/index.dart';

import 'widget/show_image_after_selfie.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  String? imageLivePath;

  @override
  Widget build(BuildContext context) {
    return imageLivePath == null
        ? CustomInfoHandler(
            image: Assets.selfie,
            title: AppStrings.selfieImage,
            subTitle: AppStrings.takeYourSelfiePhotoWithNiceSmile,
            onPressed: () async {
              M7CapturedImage? response =
                  await M7LivelynessDetection.instance.detectLivelyness(
                context,
                config: M7DetectionConfig(
                  steps: [
                    M7LivelynessStepItem(
                      step: M7LivelynessStep.turnLeft,
                      title: "Turn Left",
                      isCompleted: false,
                    ),
                    M7LivelynessStepItem(
                      step: M7LivelynessStep.turnRight,
                      title: "Turn Right",
                      isCompleted: false,
                    ),
                    M7LivelynessStepItem(
                      step: M7LivelynessStep.smile,
                      title: "Smile",
                      isCompleted: false,
                    ),
                  ],
                  startWithInfoScreen: false,
                  allowAfterMaxSec: false,
                ),
              );
              setState(() {
                imageLivePath = response?.imgPath;
              });
            },
            titleButton: AppStrings.Continue,
          )
        : ShowImageAfterSelfie(
            imageLivePath: imageLivePath,
          );
  }
}
