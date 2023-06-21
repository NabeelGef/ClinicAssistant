import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:dio/dio.dart';

class ClockTimeRepository {
  static Future<WorkTimeClock>? getWorkTimeClocks(
      String workTimeId, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    String path = "${API.BaseUrlBack}" +
        "${API.doctorsBack}" +
        "/${API.appoitment}" +
        "/${API.patientBack}" +
        "/${API.worktime}" +
        "/$workTimeId";
    WorkTimeClock workTimeClock = WorkTimeClock();
    Response response = await API.dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      workTimeClock = WorkTimeClock.fromJson(response.data);
    }
    return workTimeClock;
  }
}
