import 'package:clinicassistant/model/login_token.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  //التعامل مع قاعدة البيانات
  static Dio dio = Dio();
  String BASEURL = "http://192.168.43.206:3000/patients";
  String LOGINURL = "/login";

  Future<AccessToken> loginRepo(String email, String password) async {
    AccessToken accessToken = AccessToken();
    try {
      var response = await dio.post('$BASEURL' + '$LOGINURL',
          data: {'phoneNumber': email, 'password': password});

      print(response.statusCode);
      if (response.statusCode == 201) {
        accessToken = AccessToken.fromJson(response.data);
      } else if (response.statusCode == 401) {
        //اعادة رسالة لعدم وجود المستخدم
        //accessToken = AccessToken.fromJson(response.statusMessage as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        //this is the message for sending a wrong form of the number
        //phoneNumber must match /^09\\d{8}$/ regular expression

        if (response.statusMessage ==
            "phoneNumber must match /^09\\d{8}\$/ regular expression") {}
      }
      return accessToken;
    } catch (exception) {
      throw Exception("Failed to create user: $exception ");
    }
  }
}
