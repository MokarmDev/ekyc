import 'dart:io';

import 'package:http/http.dart' as http;

class ServicesApi {
  final String baseUrl = 'http://192.168.1.104:5000/api';

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
      print('response $response');
      return true;
    } else {
      print('حدث خطأ أثناء إرسال الصورة');
      return false;
    }
  }
}
