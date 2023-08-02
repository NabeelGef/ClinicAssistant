import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/login_token.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  //التعامل مع قاعدة البيانات

  Future<AccessToken> loginRepo(String email, String password) async {
    var accessToken;
    var response;
    print("Email : $email , PAssword : $password");
    try {
      response = await API.dio.post(
          '${API.BaseUrlBack}' + '${API.patientsBack}' + '/${API.loginBack}',
          data: {'phoneNumber': email, 'password': password});

      if (response.statusCode == 201) {
        accessToken = AccessToken.fromJson(response.data);
        print("MyToken : ${accessToken}");
      }
      return accessToken;
    } on DioException catch (exception) {
      if (exception.response != null) {
        print("response code ${exception.response!.statusCode}");
        print("data the data data ${exception.response!.data}");
        print("message the meassage message ${exception.message}");

        if (exception.response!.statusCode == 401) {
          //اعادة رسالة لعدم وجود المستخدم
          print("am in the 401 error yohohohohoho.");
          accessToken =
              AccessToken.fromJsonTow("${exception.response!.statusCode}");
          return accessToken;
        } else if (exception.response!.statusCode == 400) {
          //this is the message for sending a wrong form of number
          //[phoneNumber must match /^09\d{8}\$/ regular expression]
          print("am here in the 400 error zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
          accessToken =
              AccessToken.fromJsonTow("${exception.response!.statusCode}");
          return accessToken;
        }
      } else {
        print(exception.message);
      }

      throw Exception("Failed to create user: $exception ");
    }
  }
}
