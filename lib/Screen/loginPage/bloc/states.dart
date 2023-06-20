
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginStates
{
  const LoginStates();
}

class InitialLoginStates extends LoginStates
{

}

class LoadingLoginStates extends LoginStates
{

}
class SuccessLoginStates extends LoginStates
{
  final String successMessage;
  SuccessLoginStates(this.successMessage);

}

class ErrorLoginStates extends LoginStates
{
  late final String errorMessage;
}