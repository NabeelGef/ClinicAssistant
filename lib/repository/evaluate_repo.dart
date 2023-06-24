import 'package:clinicassistant/Constant/api.dart';
import 'package:dio/dio.dart';

class EvaluateRepo {
  static Future<String>? evaluate(
      double eval, String token, String doctorId) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      Response response = await API.dio.put(
          "${API.BaseUrlBack}" +
              "${API.doctorsBack}" +
              "/${API.evaluateBack}" +
              "/$doctorId",
          data: {'evaluate': eval},
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return "تمّ التقييم بنجاح";
      }
      return "";
    } catch (e, s) {
      print("Error in Evaluating : $e in $s");
      return "";
    }
  }

  static Future<String?>? getEvaluate(String? token, String doctorId) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      Response response = await API.dio.get(
          "${API.BaseUrlBack}" +
              "${API.doctorsBack}" +
              "/${API.evaluateBack}" +
              "/$doctorId",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data['evaluate'];
      }
      return null;
    } catch (e, s) {
      print("Get Evaluate is : $e , in $s");
      return null;
    }
  }
}
