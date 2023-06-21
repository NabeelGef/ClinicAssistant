import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/profileClinic.dart';
import 'package:dio/dio.dart';

class ClinicProfileRepository {
  static Future<ProfileClinic>? getDetailClinic(String id) async {
    ProfileClinic profileClinic = ProfileClinic();
    Response response = await API.dio.get("${API.BaseUrlBack}" +
        "${API.clinicsBack}" +
        "/${API.patientBack}" +
        "/$id");
    if (response.statusCode == 200) {
      profileClinic = ProfileClinic.fromJson(response.data);
    }
    return profileClinic;
  }
}
