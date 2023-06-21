import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

class RemainRepository {
  static Future<String?>? getRemainClocks(String appointmentId) async {
    String? message;
    Response response = await API.dio.fetch(
      RequestOptions(
          baseUrl: "${API.BaseUrlBack}" +
              "${API.doctorsBack}" +
              "/${API.appoitment}" +
              "/${API.patientBack}" +
              "/${appointmentId}",
          method: 'GET'),
    );
    if (response.statusCode == 200) {
      message = response.data['message'];
    }
    return message;
  }
}
