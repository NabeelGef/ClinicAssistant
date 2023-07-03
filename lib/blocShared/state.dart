// ignore_for_file: public_member_api_docs, sort_constructors_first
class SharedState {
  GetTokenState? getTokenState;
  GetLoginState? getLoginState;
  SharedState({this.getTokenState, this.getLoginState});
}

class GetTokenState extends SharedState {
  String? token;
  GetTokenState({
    required this.token,
  });
}

class GetLoginState extends SharedState {
  bool? isLogin;
  GetLoginState({
    required this.isLogin,
  });
}
