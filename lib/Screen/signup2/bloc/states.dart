abstract class SignUp2States {
  SignUp2States();
}

class InitialSignUp2States extends SignUp2States {}

class SuccessSignUp2States extends SignUp2States {
  final String successMessage;
  SuccessSignUp2States(this.successMessage);
}

class ErrorSignUp2States extends SignUp2States {}

class LoadingSignUp2States extends SignUp2States {}
