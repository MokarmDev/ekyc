import 'package:m7_livelyness_detection/index.dart';

livenessCheck(BuildContext context) async {
  final M7CapturedImage? response =
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
      allowAfterMaxSec: true,
    ),
  );

  print('=================================' +
      response!.imgPath +
      '==========================================');
}
