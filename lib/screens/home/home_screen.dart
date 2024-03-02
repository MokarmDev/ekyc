import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:ekyc/common/custom_button.dart';
import 'package:ekyc/constants/app_text_styles.dart';
import 'package:ekyc/screens/success/success_screen.dart';
import 'package:ekyc/services/services_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils_project/flutter_utils_project.dart';

import '../../constants/app_strings.dart';

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
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: Column(
          children: [
            50.height,
            Text(
              AppStrings.CapturedIDCard,
              style: CustomTextStyles.titleStyle,
            ),
            10.height,
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
                  width: 300,
                  height: 200,
                  child: Image.file(
                    photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            90.height,
            Visibility(
              visible: photos.length == 2,
              child: CustomButton(
                onPressed: () async {
                  final api = ServicesApi();
                  var response =
                      await api.sendImageToOCR(photos[0].path, photos[1].path);
                  print('Has responded $response');
                  if (response) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessScreen(),
                        ));
                  } else {
                    print('Error sending request');
                  }
                },
                text: 'SEND',
              ),
            ),
            Visibility(
              visible: photos.length == 2,
              child: TextButton(
                onPressed: () {
                  onPressed();
                  photos.clear();
                },
                child: const Text('CANCEL'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
