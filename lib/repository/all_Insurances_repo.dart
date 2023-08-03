import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/insurance.dart';
import 'package:dio/dio.dart';

class AllInsurancesRepo {
  static Future<Insurance?> getAllInsurances() async {
    Response response =
        await API.dio.get("${API.BaseUrlBack}" + "${API.insurances}");
    if (response.statusCode == 200) {
      return Insurance.fromJson(response.data);
    }
    return null;
  }
}
