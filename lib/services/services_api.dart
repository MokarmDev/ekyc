import 'dart:convert';
import 'dart:io';

import 'package:ekyc/database/cache/cache_helper.dart';
import 'package:ekyc/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ServicesApi {
  final String baseUrl = 'http://192.168.0.101:5000/api';

  Future<bool> checkConnToServer() async{
    var response = await http.get(Uri.base);
    return jsonDecode(response.body);
  }

  Future<bool> sendImageToOCR(File front, File back) async {
    var url = Uri.parse('$baseUrl/ocr');
    List idFront = await front.readAsBytes();
    List idBack = await back.readAsBytes();

    var request = http.MultipartRequest('POST', url);

    request.files.add(http.MultipartFile.fromString(
      'front',
      idFront.toString(),
      // contentType: MediaType('front', 'jpg'),
    ));
    request.files.add(http.MultipartFile.fromString(
      'back',
      idBack.toString(),
      // contentType: MediaType('back', 'jpg'),
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('تم إرسال الصورة بنجاح');
      print('response ${response.stream}');
      return true;
    } else {
      print('حدث خطأ أثناء إرسال الصورة');
      return false;
    }
  }

  Future<bool> sendToOCRNew(File front, File back) async {
    var url = Uri.parse('$baseUrl/ocr');

    var request = http.MultipartRequest('POST', url);
    var frontFile = await http.MultipartFile.fromPath('front', front.path, contentType: MediaType('image', 'jpeg'));
    var backFile = await http.MultipartFile.fromPath('back', back.path, contentType: MediaType('image', 'jpeg'));

    request.files.add(frontFile);
    request.files.add(backFile);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('OCR request was sent successfully');
      var responseJson = jsonDecode(await response.stream.bytesToString());
      if(responseJson['result'] as bool == false){
        print("OCR failed");
        return false;
      }
      print(responseJson['content']);
      getIt<CacheHelper>().saveData(key: 'ocrData', value: jsonEncode(responseJson['content']));
      return true;
    } else {
      print('Server is not reachable: OCR');
      return false;
    }
  }

  Future<bool> sendToDeepFace({required File front, required File live_image}) async {
    var url = Uri.parse('$baseUrl/deepface');

    var request = http.MultipartRequest('POST', url);
    var frontFile = await http.MultipartFile.fromPath('front', front.path, contentType: MediaType('image', 'jpeg'));
    var liveFile = await http.MultipartFile.fromPath('live_image', live_image.path, contentType: MediaType('image', 'jpeg'));
    request.files.add(frontFile);
    request.files.add(liveFile);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('Deepface request was sent successfully');
      var responseJson = jsonDecode(await response.stream.bytesToString());
      if(responseJson['result'] as bool == false){
        print("Deepface failed");
        return false;
      }
      print(responseJson);
      getIt<CacheHelper>().saveData(key: 'deepfaceData', value: responseJson['result']);
      return true;
    } else {
      print('Server is not reachable: deepface');
      return false;
    }
  }
}
