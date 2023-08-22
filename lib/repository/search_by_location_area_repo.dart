import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:dio/dio.dart';

class SearchByLocation {
  static Future<Clinic?> searchByArea(String areaId, String specialId) async {
    Clinic? clinic;
    Response response = await API.dio.get("${API.BaseUrlBack}" +
        "${API.clinicsBack}" +
        "/${API.area}" +
        "/${areaId}" +
        "/${specialId}");
    if (response.statusCode == 200) {
      clinic = Clinic.fromJson(response.data);
    }
    return clinic;
  }

  static Future<Clinic?> searchByMyLocation(
      double Latitude, double Longitude, String specialId) async {
    Clinic? clinic;
    final headers = {
      'Content-Type': 'application/json',
    };

    Response response = await API.dio.post(
        "${API.BaseUrlBack}" +
            "${API.clinicsBack}" +
            "/${API.longitude_latitude}" +
            "/${API.specialty}" +
            "/${specialId}",
        data: {"Latitude": Latitude, "Longitude": Longitude},
        options: Options(headers: headers));
    if (response.statusCode == 201) {
      clinic = Clinic.fromJson(response.data);
      print("Response My Location : ${response.data}");
    }
    return clinic;
  }
}
