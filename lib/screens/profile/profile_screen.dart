import 'dart:convert';
import 'dart:io';

import 'package:ekyc/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/widgets.dart';

import '../../constants/app_assets.dart';
import '../../database/cache/cache_helper.dart';
import '../../services/service_locator.dart';

class ProfileScreen extends StatelessWidget {
  final ocrData = jsonDecode(getIt<CacheHelper>().getDataString(key: 'ocrData')!);
  final deepfaceData = getIt<CacheHelper>().getData(key: 'deepfaceData');
  final live_image = getIt<CacheHelper>().getData(key: 'live_image');
   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                Assets.clip,
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.25,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: CircleAvatar(
                  backgroundImage:
                  FileImage(File(live_image)),
                  radius: 30,
                )),
          ),
          Positioned(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          Text('National ID: ${ocrData['national_id']}', style: TextStyle(fontSize: 15),),
                          Divider(),
                          Text('Issuing Date: ${ocrData['issuing_date']}', style: TextStyle(fontSize: 15),),
                          Divider(),
                          Text('Expiry Date: ${ocrData['expiry_date']}', style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}
