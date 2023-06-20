import 'package:clinicassistant/model/login_token.dart';
import 'package:clinicassistant/model/user.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class LoginRepository{

  //التعامل مع قاعدة البيانات
  static Dio dio = Dio();
  String BASEURL = "http://10.0.2.2:3000/patients" ;
  String LOGINURL = "/login" ;


    Future<AccessToken> loginRepo(String email , String password)async
  {
     AccessToken accessToken = AccessToken();
     try
     {
       var response = await dio.post(
           '$BASEURL'+'$LOGINURL' ,
         data: {
             'phoneNumber' : email,
             'password' : password
         }
       );

       print(response.statusCode) ;
       if(response.statusCode == 201)
       {
         print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr") ;
         print(response.data) ;
         accessToken = AccessToken.fromJson(response.data);
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
       return accessToken;

     }catch(exception)
    {
      throw Exception("Failed to create user: $exception ") ;
    }

  }



}