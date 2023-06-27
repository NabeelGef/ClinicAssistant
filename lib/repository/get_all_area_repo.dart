import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/area.dart';
import 'package:dio/dio.dart';

class GetAllAreaRepo {
  static Future<AllArea?> getAllArea(String? governorateId) async {
    AllArea allArea = AllArea();
    try {
      Response response = await API.dio.get("${API.BaseUrlBack}" +
          "${API.governorates}" +
          "/${governorateId}" +
          "/${API.areas}");
      if (response.statusCode == 200) {
        allArea = AllArea.fromJson(response.data);
        return allArea;
      }
    } catch (e, s) {
      print("Error in Get ALL Areas : $e in \n$s");
      return null;
    }
    return null;
  }
}
