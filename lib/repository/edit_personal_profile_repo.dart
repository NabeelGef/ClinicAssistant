import 'dart:io';

import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class EditPersonalProfile {
  static Future<String?> editProfile(File? image, String token) async {
    String fileName = image!.path.split('/').last;

    String? mimeType = mime(fileName);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    API.dio.options.headers["Content-Type"] = "multipart/form-data";
    print("FileName : $fileName");
    print("path : ${image.path}");
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path,
          filename: fileName, contentType: MediaType(mimee, type)),
    });
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
    Response response = await API.dio.put(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.updateProfilePicture}",
        data: formData,
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      return response.data['message'];
    }
    return null;
  }
}
