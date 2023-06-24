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

  static Future<Clinic>? SearchClininByName(String name) async {
    Clinic clinic = Clinic();
    Response response = await API.dio.post(
        "${API.BaseUrlBack}" +
            "${API.clinicsBack}" +
            "/${API.filterClinicsByName}",
        data: {'filterName': name});

    if (response.statusCode == 201) {
      clinic = Clinic.fromJson(response.data);
      print("Response Search 2============ ${response.data}");
    }
    return clinic;
  }
}
