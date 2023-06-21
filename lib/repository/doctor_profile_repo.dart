import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/profileDoctor.dart';
import 'package:dio/dio.dart';

class DoctorProfileRepository {
  static Future<ProfileDoctor>? getDetailDoctor(String id) async {
    ProfileDoctor profileDoctor = ProfileDoctor();
    Response response = await API.dio.get("${API.BaseUrlBack}" +
        "${API.doctorsBack}" +
        "/${API.detailDoctors}" +
        "/$id");
    if (response.statusCode == 200) {
      profileDoctor = ProfileDoctor.fromJson(response.data);
    }
    return profileDoctor;
  }
}
