import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/doctorClinicBook.dart';
import 'package:dio/dio.dart';

class DoctorClinicBookRepository {
  static Future<DoctorClinicBook>? getDoctorClinicBook(
      String doctorId, String clinicId, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    DoctorClinicBook doctorClinicBook = DoctorClinicBook();
    String path = "${API.BaseUrlBack}" +
        "${API.doctorsBack}" +
        "/${API.clinicBack}" +
        "/$clinicId" +
        "/$doctorId";
    Response response = await API.dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      doctorClinicBook = DoctorClinicBook.fromJson(response.data);
    }

    return doctorClinicBook;
  }
}
