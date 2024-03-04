import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:ekyc/common/custom_button.dart';
import 'package:ekyc/constants/app_colors.dart';
import 'package:ekyc/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../services/service_locator.dart';
import '../../services/services_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final photos = <File>[];

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CameraCamera(
                cameraSide: CameraSide.front,
                resolutionPreset: ResolutionPreset.ultraHigh,
                enableZoom: false,
                mode: CameraMode.ratio4s3,
                onFile: (file) {
                  photos.add(file);
                  Navigator.pop(context);
                  setState(() {});
                },
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: photos.isEmpty
          ? const HomeBodyEmpty()
          : ShowImageCard(
              photos: photos,
              onPressed: openCamera,
            ),
      floatingActionButton: Visibility(
        visible: photos.length < 2,
        child: FloatingActionButton(
          onPressed: openCamera,
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}

class HomeBodyEmpty extends StatelessWidget {
  const HomeBodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.kPrimaryColor,
              size: 50.0,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings
                  .PleaseTakePicturesOfYourIDCardAsPortrayedBelowMakeSureThePictureIsAsClearAsPossibleAndGlareFree,
              style: CustomTextStyles.smallText
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            Image.asset(Assets.card),
          ],
        ),
      ),
    );
  }
}

class ShowImageCard extends StatelessWidget {
  final List<File> photos;
  final Function() onPressed;
  const ShowImageCard(
      {super.key, required this.photos, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    File front, back;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 10.h,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Text(
              AppStrings.CapturedIDCard,
              style: CustomTextStyles.titleStyle,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppStrings
                  .YouCanSendThePhotoIfItIsClearAndIfItIsNotClearYouCanRetakeThePhoto,
              style: CustomTextStyles.smallText,
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: photos.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300.w,
                  height: 200.h,
                  child: Image.file(
                    photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            Visibility(
              visible: photos.length == 2,
              child: CustomButton(
                onPressed: () {
                  front = photos[0];
                  back = photos[1];

                  getIt<ServicesApi>().sendImageToOCR(front, back);

                  Navigator.pushNamed(context, '/success');
                },
                text: AppStrings.send,
              ),
            ),
            Visibility(
              visible: photos.length == 2,
              child: TextButton(
                onPressed: () {
                  onPressed();
                  photos.clear();
                },
                child: Text(
                  AppStrings.retake,
                  style: CustomTextStyles.titleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
