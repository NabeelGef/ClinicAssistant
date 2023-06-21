import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:dio/dio.dart';

class AllClinicsRepository {
  static Future<Clinic>? getClinics() async {
    Clinic clinic = Clinic();
    Response response =
        await API.dio.get("${API.BaseUrlBack}" + "${API.clinicsBack}");
    if (response.statusCode == 200) {
      //print(response.data);
      clinic = Clinic.fromJson(response.data);
    }
    return clinic;
  }
}
