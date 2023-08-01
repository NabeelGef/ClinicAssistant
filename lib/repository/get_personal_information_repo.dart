import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/personl_information.dart';
import 'package:dio/dio.dart';

class GetPersonalInformationRepo{
  
  static Future<Patient?> getMyAccount(String token) async{
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Response response =await API.dio.get("${API.BaseUrlBack}" +
        "${API.patientsBack}"+"/${API.myAccount}" ,
        options: Options(headers: headers));
    if(response.statusCode == 200){
      return Patient.fromJson(response.data);
    }
    return null;
  }
}