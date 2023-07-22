import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/cancle.dart';
import 'package:dio/dio.dart';

class CancleRepo {
  static Future<Cancle?> getStateCancle(String Id, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Cancle? cancle;
    Response response = await API.dio.get(
        "${API.BaseUrlBack}" +
            "${API.patientsBack}" +
            "/${API.hour_to_appointment}" +
            "/$Id",
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      cancle = Cancle.fromJson(response.data);
    }
    return cancle;
  }
  static Future<String?> makeCancle(String Id , String token) async{
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    String? message;
    Response response =await API.dio.put(
      "${API.BaseUrlBack}" +
          "${API.patientsBack}" +
          "/${API.cancel_appointment}" +
          "/$Id",options: Options(headers: headers));
    if (response.statusCode == 200) {
    message = response.data['message'];
    }
return message;

  }
}
