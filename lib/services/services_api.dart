import 'package:http/http.dart' as http;

class ServicesApi {
  //final String serverIP = '192.168.0.94';
  final String baseUrl = 'http://192.168.0.94:5000/api';

  Future<bool> sendImageToOCR(String front, String back) async {
    var url = Uri.parse('$baseUrl/ocr');

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('front', front));
    request.files.add(await http.MultipartFile.fromPath('back', back));

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
