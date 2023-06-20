import 'package:clinicassistant/model/login_token.dart';
import 'package:clinicassistant/model/signup_post.dart';
import 'package:clinicassistant/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class SignUp2Repository{

  //التعامل مع قاعدة البيانات
  static Dio dio = Dio();
  String BASEURL = "http://10.0.2.2:3000/patients" ;
  String LOGINURL = "/signup" ;


  Future<SignUpPost?> signUpRepo(String firstName ,
  String lastName ,
  String userName ,
  String phoneNumber ,
  String password ,
  String day ,
  String month ,
  int year,
  String gender)async
  {
  SignUpPost patientId = SignUpPost();
    try
    {
      var response = await dio.post(
          '$BASEURL'+'$LOGINURL' ,
          data: {
            "phoneNumber":phoneNumber,
            "password":password,
            "firstname":firstName,
            "lastname":lastName,
            "birthDate":"$year-$month-$day",
            "gender":gender
          }
      );

      print(response.statusCode) ;
      if(response.statusCode == 201)
      {
        print(response.data) ;
        //this is the patient id
        patientId = SignUpPost.fromJson(response.data);
      }
      else if(response.statusCode == 401)
      {
        //اعادة رسالة لعدم وجود المستخدم
        //accessToken = AccessToken.fromJson(response.statusMessage as Map<String, dynamic>);
        print("1111111111111111111111111111111111111") ;

      }

      else if (response.statusCode == 400)
      {
        //this is the message for sending a wrong form of the number
        //phoneNumber must match /^09\\d{8}$/ regular expression

        print("4444444444444444444444444444444444444444444") ;
        if(response.statusMessage == "phoneNumber must match /^09\\d{8}\$/ regular expression")
        {
        }
      }
      return patientId;

    }catch(exception)
    {
      throw Exception("Failed to create user: $exception ") ;
    }

  }



}