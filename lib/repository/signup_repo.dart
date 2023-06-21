import 'package:clinicassistant/model/signup_post.dart';
import 'package:dio/dio.dart';

class SignUp2Repository {
  //التعامل مع قاعدة البيانات
  static Dio dio = Dio();
  String BASEURL = "http://192.168.43.206:3000/patients";
  String LOGINURL = "/signup";

  Future<SignUpPost?> signUpRepo(
      String firstName,
      String lastName,
      String userName,
      String phoneNumber,
      String password,
      String day,
      String month,
      int year,
      String gender) async {
    SignUpPost patientId = SignUpPost();
    try {
      var response = await dio.post(
        '$BASEURL' + '$LOGINURL',
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
          "firstname": firstName,
          "lastname": lastName,
          "birthDate": "$year-$month-$day",
          "gender": gender
        },
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.data);
        //this is the patient id
        patientId = SignUpPost.fromJson(response.data);
        print("Patient ID Is : ${patientId.patientId}");
      } else if (response.statusCode == 401) {
        //اعادة رسالة لعدم وجود المستخدم
        //accessToken = AccessToken.fromJson(response.statusMessage as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        //this is the message for sending a wrong form of the number
        //phoneNumber must match /^09\\d{8}$/ regular expression
        if (response.statusMessage ==
            "phoneNumber must match /^09\\d{8}\$/ regular expression") {}
      }
      return patientId;
    } catch (exception, s) {
      throw Exception("Failed to create user: $exception in $s  ");
    }
  }
}
