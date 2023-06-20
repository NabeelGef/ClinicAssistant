
import 'package:flutter/material.dart';

@immutable
abstract class SignUp2Events
{
  const SignUp2Events();
}

class SignUp2DataSend extends SignUp2Events
{
  String? firstName ;
  String? lastName ;
  String? userName ;
  String? phoneNumber ;
  String? password ;
  String? day ;
  String? month ;
  int? year ;
  String? gender;

  SignUp2DataSend({
    required this.firstName ,
    required this.lastName ,
    required this.userName ,
    required this.phoneNumber ,
    required this.password ,
    required this.year,
    required this.month,
    required this.day ,
    required this.gender ,

});
}

