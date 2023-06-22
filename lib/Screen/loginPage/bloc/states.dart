import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginStates {
  const LoginStates();
}

class InitialLoginStates extends LoginStates {}

class LoadingLoginStates extends LoginStates {}

class SuccessLoginStates extends LoginStates {
  final String successMessage;
  final String? token;
  final bool? isLogin;
  SuccessLoginStates(this.successMessage, this.token, this.isLogin);
}

class ErrorLoginStates extends LoginStates {
  late final String errorMessage;
}
