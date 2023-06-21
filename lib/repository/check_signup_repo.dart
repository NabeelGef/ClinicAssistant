import 'package:clinicassistant/model/login_token.dart';
import 'package:clinicassistant/model/user.dart';
import 'package:clinicassistant/model/verify.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class CheckSignUpRepository{

  //التعامل مع قاعدة البيانات
  static Dio dio = Dio();
  String BASEURL = "http://10.0.2.2:3000/patients" ;
  String LOGINURL = "/verify" ;
  String? returnMessage;
  Verify verify = Verify();
  Future<String?> checkSignUpRepo(String patientId , String verificationCode)async
  {
    try
    {
      print("i get here ") ;
      int code = int.parse(verificationCode) ;
      var response = await dio.post(
          '$BASEURL'+'$LOGINURL' ,
          data: {
            'patientId' : patientId,
            'code' : code
          }
      );
      verify = Verify.fromJson(response.data);
      print(response.statusCode) ;
      if(response.statusCode == 201)
      {
        print(verify.message) ;
        returnMessage = verify.message ;
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

      }
      return response.statusMessage!;

    }catch(exception)
    {
      throw Exception("Failed to create user: $exception ") ;
    }

  }


  String? convert(String id , String code)
  {
    checkSignUpRepo(id, code);

    return returnMessage! ;
  }

}