import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:ekyc/common/custom_button.dart';
import 'package:ekyc/constants/app_colors.dart';
import 'package:ekyc/constants/app_text_styles.dart';
import 'package:ekyc/database/cache/cache_helper.dart';
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
                mode: CameraMode.ratio16s9,
                flashModes: const [FlashMode.off],
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

class ShowImageCard extends StatefulWidget {
  final List<File> photos;
  final Function() onPressed;
  bool isLoading = false;
   ShowImageCard(
      {super.key, required this.photos, required this.onPressed});

  @override
  State<ShowImageCard> createState() => _ShowImageCardState();
}

class _ShowImageCardState extends State<ShowImageCard> {
  @override
  Widget build(BuildContext context) {
    File front, back;
    bool ocrData = false;
    bool deepfaceData = false;

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
            widget.isLoading ? Padding(
              padding: EdgeInsets.all(50),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CircularProgressIndicator())) : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.photos.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300.w,
                  height: 200.h,
                  child: Image.file(
                    widget.photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            Visibility(
              visible: widget.photos.length == 2 && widget.isLoading == false,
              child: CustomButton(
                onPressed: () async {
                  Future.wait([getIt<ServicesApi>().checkConnToServer()]).then((value) async {
                    if(value[0]){
                      print('Connection to server is successfu');
                      setState(() {
                        widget.isLoading = true;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please wait, This may take a while'), duration: Duration(seconds: 5),));
                      });
                      front = widget.photos[0];
                      back = widget.photos[1];
                      ocrData = await getIt<ServicesApi>().sendToOCR(front, back);
                      File liveImage = File(getIt<CacheHelper>().getDataString(key: 'live_image')!);
                      deepfaceData = await getIt<ServicesApi>().sendToDeepFace(front: front, live_image: liveImage);
                      widget.isLoading = false;
                      if(ocrData && deepfaceData){
                        Navigator.pushReplacementNamed(context, '/success');
                      }
                      else{
                        Navigator.pushNamed(context, '/failure');
                      }
                    }
                    else{
                      print('error');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There was an error connecting to server, please check connection'), duration: Duration(seconds: 5),));}
                  });

                },
                text: AppStrings.send,
              ),
            ),
            Visibility(
              visible: widget.photos.length == 2 && widget.isLoading == false,
              child: TextButton(
                onPressed: () {
                  widget.onPressed();
                  widget.photos.clear();
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
