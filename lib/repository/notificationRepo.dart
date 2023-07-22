import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/delays_and_warnings.dart';
import 'package:clinicassistant/model/remainder_notification.dart';
import 'package:dio/dio.dart';

class NotificationRepo {
  static Future<RemainderNotification?> RemainderNotify(String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.patient_reminders}",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      return RemainderNotification.fromJson(response.data);
    }
    return null;
  }

  static Future<DelaysAndWarningsNotification?> DelaysAndWarningsNotify(
      String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" + "${API.patientsBack}" + "/${API.patient_delays}",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      return DelaysAndWarningsNotification.fromJson(response.data);
    }
    return null;
  }
}
