import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

class BookNowRepository {
  static Future<String?>? booknow(String appointmentId, String token) async {
    String? message;
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    Response response = await API.dio.fetch(
      RequestOptions(
          baseUrl: "${API.BaseUrlBack}" +
              "${API.doctorsBack}" +
              "/${API.appoitment}" +
              "/${API.patientBack}" +
              "/${appointmentId}",
          headers: headers,
          method: 'POST'),
    );
    print("APPIONTMENT ID : $appointmentId");
    if (response.statusCode == 201) {
      message = response.data['mesaage'];
    }
    return message;
  }
}
