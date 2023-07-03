import 'package:clinicassistant/blocShared/event.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final SharedPreferences sharedPreferences;

  SharedBloc({required this.sharedPreferences})
      : super(SharedState(
            getTokenState: GetTokenState(
                token: sharedPreferences.getString('token') ?? null),
            getLoginState: GetLoginState(
                isLogin: sharedPreferences.getBool('isLogin') ?? false)));

  @override
  Stream<SharedState> mapEventToState(SharedEvent event) async* {
    if (event is SaveDataToken) {
      yield* saveToken(event.token!);
    }
    if (event is SaveDataLogin) {
      yield* saveLogin(event.isLogin!);
    }
    if (event is SignoutLogin) {
      yield* signout();
    }
  }

  Stream<SharedState> saveToken(String token) async* {
    await sharedPreferences.setString('token', token);
    String? newToken = sharedPreferences.getString('token');
    yield SharedState(
        getLoginState: state.getLoginState,
        getTokenState: GetTokenState(token: newToken));
  }

  Stream<SharedState> saveLogin(bool isLogin) async* {
    await sharedPreferences.setBool('isLogin', isLogin);
    bool? newisLogin = sharedPreferences.getBool('isLogin');
    yield SharedState(
        getTokenState: state.getTokenState,
        getLoginState: GetLoginState(isLogin: newisLogin));
  }

  Stream<SharedState> signout() async* {
    await sharedPreferences.setBool('isLogin', false);
    bool? newisLogin = sharedPreferences.getBool('isLogin');
    yield SharedState(
        getTokenState: GetTokenState(token: null),
        getLoginState: GetLoginState(isLogin: newisLogin));
  }
}
