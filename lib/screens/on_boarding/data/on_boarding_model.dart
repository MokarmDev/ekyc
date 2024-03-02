import '../../../constants/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    imagePath: Assets.onBoarding1,
    title: 'Now it’s your time',
  ),
  OnBoardingModel(
    imagePath: Assets.onBoarding2,
    title: 'Create your digital identity with high privacy',
  ),
  OnBoardingModel(
    imagePath: Assets.onBoarding3,
    title: 'Go digital with complete confidence',
  ),
  OnBoardingModel(
    imagePath: Assets.livelynessDetection,
    title:
        'We use this selfie to compare with the mandatory photo on the next step',
  ),
];
