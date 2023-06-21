import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

import '../model/specialist.dart';

class SpecialRepository {
  static Future<Specialists>? getSpecialist() async {
    Specialists specialists = Specialists();
    Response response =
        await API.dio.get("${API.BaseUrlBack}" + "{$API.specialistBack}");
    if (response.statusCode == 200) {
      //print(response.data);
      specialists = Specialists.fromJson(response.data);
    }
    return specialists;
  }
}
