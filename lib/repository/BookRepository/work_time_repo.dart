import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/worktime.dart';
import 'package:dio/dio.dart';

class WorkTimeRepository {
  static Future<WorkTime>? getWorkTime(
      String doctorId, String clinicId, String token) async {
    WorkTime workTime = WorkTime();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    String path = "${API.BaseUrlBack}" +
        "${API.doctorsBack}" +
        "/${API.worktime}" +
        "/$doctorId" +
        "/$clinicId";
    Response response = await API.dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      workTime = WorkTime.fromJson(response.data);
    }
    return workTime;
  }
}
