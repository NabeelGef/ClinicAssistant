import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

import '../model/doctor.dart';

class AllDoctorsRepository {
  static Future<Doctor>? getDoctors(
      bool? orderByEvaluate, int? subSpecialtyId, String? filterName) async {
    Map<String, dynamic> data = {
      'orderByEvaluate': orderByEvaluate,
      'subSpecialtyId': subSpecialtyId,
      'filterName': filterName,
    };
    Doctor doctor = Doctor(doctor: []);
    Response response = await API.dio.post(
        "${API.BaseUrlBack}" + "${API.doctorsBack}" + "/${API.alldoctorsBack}",
        data: data);
    if (response.statusCode == 201) {
      doctor = Doctor.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception();
    }
    return doctor;
  }
}
