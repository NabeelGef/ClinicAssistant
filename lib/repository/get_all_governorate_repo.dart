import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/governorate.dart';
import 'package:dio/dio.dart';

class GetAllGovernorateRepo {
  static Future<AllGovernorate?> getAllGovernorate() async {
    AllGovernorate allGovernorate = AllGovernorate();
    try {
      Response response =
          await API.dio.get("${API.BaseUrlBack}" + "${API.governorates}");
      if (response.statusCode == 200) {
        allGovernorate = AllGovernorate.fromJson(response.data);
        return allGovernorate;
      }
    } catch (e, s) {
      print("Error in Get ALL Governorates : $e in \n$s");
      return null;
    }
    return null;
  }
}
