import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/signup_post.dart';
import 'package:dio/dio.dart';

class SignUp2Repository {
  //التعامل مع قاعدة البيانات

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
    var patientId;
    var response ;
    try {
      print(
          "PATH = '${API.BaseUrlBack}' + '${API.patientsBack}' + '/${API.signupBack}");
        response = await API.dio.post(
        '${API.BaseUrlBack}' + '${API.patientsBack}' + '/${API.signupBack}',
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
      }

      return patientId;
    } on DioException catch (exception, s) {

     if (exception.response!.statusCode == 400) {

    //في حالتين
    //الأولى أن يكون الرقم المدخل شكله خطأ أو لا يتكون من 10 ارقام ورسالة الخطأ على الشكل التالي
    //"message": [
    //         "يجب أن يكون الرقم من 10 خانات ويبدأ ب 09"
    //],

    //الثانية أن يكون الرقم المدخل موجود بالتالي رسالة الخطا هي
    //"message": "this phone number already exist"

    if (response.statusMessage == "يجب أن يكون الرقم من 10 خانات ويبدأ ب 09")
    {
     print("am here in the wrong form of number error") ;
     //هون ببعث رسالة الخطأ وهناك بستقبلها وبقول إنو في خطأ بشكل الرقم
    }

    else if(response.statusMessage == "this phone number already exist")
    {
      print("am here in the exist number in the data base") ;
      //هون كمان ببعث رسالة الخطأ إنو الرقم موجود

    }

    }
      throw Exception("Failed to create user: $exception in $s  ");
    }
  }
}
