import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

import '../model/doctor.dart';

class AllDoctorsRepository {
  static Future<Doctor?> getDoctors(
      bool? orderByEvaluate, int? subSpecialtyId, String? filterName) async {
    Map<String, dynamic> data = {
      'orderByEvaluate': orderByEvaluate,
      'subSpecialtyId': subSpecialtyId,
      'filterName': filterName,
    };
    final headers = {
      'Content-Type': 'application/json',
    };

    Response response = await API.dio.post(
        "${API.BaseUrlBack}" + "${API.doctorsBack}" + "/${API.alldoctorsBack}",
        data: data,
        options: Options(headers: headers));
    if (response.statusCode == 201) {
      return Doctor.fromJson(response.data);
    }
    return null;
  }

  static Future<Doctor?> filterDoctors(
      int? subSpecialtyId, int? insuranceId, String? gender) async {
    if (gender == "ذكر") {
      gender = "male";
    } else if (gender == "انثى") {
      gender = "female";
    }
    Map<String, dynamic> data = {
      'subSpecialtyId': subSpecialtyId,
      'gender': gender,
      'insuranceId': insuranceId,
    };
    print("DATA : $data");
    final headers = {
      'Content-Type': 'application/json',
    };

    Response response = await API.dio.post(
        "${API.BaseUrlBack}" + "${API.doctorsBack}" + "/${API.filterDoctor}",
        data: data,
        options: Options(headers: headers));
    if (response.statusCode == 201) {
      return Doctor.fromJson(response.data);
    }
    return null;
  }
}
