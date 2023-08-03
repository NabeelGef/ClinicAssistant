import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

class ForgetPasswordRepo {
  static Future<String?> getPatientId(String numberPhone) async {
    var data = {'phoneNumber': numberPhone};
    Response response = await API.dio.post(
        "${API.BaseUrlBack}" + "${API.patientsBack}" + "/${API.rest_password}",
        data: data);
    if (response.statusCode == 201) {
      return response.data['patientId'];
    }
    return null;
  }

  static Future<String?> verify(
      String patientId, String code, String newPassword) async {
    int newCode = int.parse(code);
    int newPatientId = int.parse(patientId);
    var data = {
      "patientId": newPatientId,
      "code": newCode,
      "newPassword": newPassword
    };
    Response response = await API.dio.post(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.rest_password_verify}",
        data: data);
    if (response.statusCode == 201) {
      return response.data['message'];
    }
    return null;
  }
}
