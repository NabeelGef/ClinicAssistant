import 'package:clinicassistant/model/current_appointment.dart';
import 'package:dio/dio.dart';

import '../Constant/api.dart';

class CurrentAppointmentRepo {
  static Future<CurrentAppointment?> getAllCurrentAppointment(
      String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    CurrentAppointment? currentAppointment;
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.my_current_appointment}",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      currentAppointment = CurrentAppointment.fromJson(response.data);
    }
    return currentAppointment;
  }

  static Future<CurrentAppointment?> getAllPreviousAppointment(
      String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    CurrentAppointment? currentAppointment;
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.my_previous_appointment}",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      currentAppointment = CurrentAppointment.fromJson(response.data);
    }
    return currentAppointment;
  }
}
