import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/profileDoctor.dart';
import 'package:dio/dio.dart';

class DoctorProfileRepository {
  static Future<ProfileDoctor>? getDetailDoctor(
      String? token, String id) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    ProfileDoctor profileDoctor = ProfileDoctor();
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" +
            "${API.doctorsBack}" +
            "/${API.detailDoctors}" +
            "/$id",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      profileDoctor = ProfileDoctor.fromJson(response.data);
    }
    return profileDoctor;
  }
}
