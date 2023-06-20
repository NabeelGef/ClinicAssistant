import 'package:flutter/material.dart';

@immutable
abstract class LoginEvents
{
  const LoginEvents();
}

class LoginDataEntry extends LoginEvents
{
  final String email;
  final String password;

  LoginDataEntry({ required this.email ,  required this.password}){}
}
