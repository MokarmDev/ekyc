import 'package:ekyc/common/custom_info_handler.dart';
import 'package:ekyc/constants/app_assets.dart';
import 'package:m7_livelyness_detection/index.dart';

class SelfieScreen extends StatelessWidget {
  const SelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    M7CapturedImage? response;

    return CustomInfoHandler(
      image: Assets.selfie,
      title: 'Selfie Image',
      subTitle: 'Take your selfie photo with nice smile',
      onPressed: () async {
        response = await M7LivelynessDetection.instance.detectLivelyness(
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
            allowAfterMaxSec: true,
          ),
        );
        if (response != null) {
          Navigator.pushNamed(context, '/home');
        }
      },
      titleButton: '',
    );
  }
}
