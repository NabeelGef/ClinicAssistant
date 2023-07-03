// ignore_for_file: public_member_api_docs, sort_constructors_first
class SharedEvent {
  SharedEvent();
}

class SaveDataToken extends SharedEvent {
  String? token;
  SaveDataToken({
    this.token,
  });
}

class SaveDataLogin extends SharedEvent {
  bool? isLogin;
  SaveDataLogin({
    this.isLogin,
  });
}

class SignoutLogin extends SharedEvent {}
