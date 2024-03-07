import 'dart:convert';
import 'dart:io';

import 'package:ekyc/database/cache/cache_helper.dart';
import 'package:ekyc/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ServicesApi {
  final String baseUrl = 'http://192.168.0.500:5000/api';

  Future<bool> checkConnToServer() async{
    try{
      var response = await http.get(Uri.parse(baseUrl));
      var body = jsonDecode(response.body);
      return body['status'] == 'running' ? true : false;
    } on SocketException catch(e){
      print('Socket exception $e');
      return false;
    }catch(e){
      print('an error has occured $e');
      return false;
    }
  }

  Future<bool> sendToOCR(File front, File back) async {
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
