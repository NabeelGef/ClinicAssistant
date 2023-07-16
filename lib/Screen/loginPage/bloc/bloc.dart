import 'package:clinicassistant/Screen/loginPage/bloc/event.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/states.dart';
import 'package:clinicassistant/model/login_token.dart';
import 'package:clinicassistant/repository/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginRepository _loginRepository;
  LoginBloc(this._loginRepository) : super(InitialLoginStates());

  static LoginBloc get(BuildContext context) => BlocProvider.of(context);

  //سوف يأخذ حدث من هنا ويعيد قناة من الحالات
  @override
  Stream<LoginStates> mapEventToState(LoginEvents events) async* {
    if (events is LoginDataEntry) {
      yield LoadingLoginStates();

      //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

      //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية

      var accessToken =
          await _loginRepository.loginRepo(events.email, events.password);

      print("This is the return from the access token :${accessToken.accessToken?.accessToken}");

      if(accessToken.accessToken?.accessToken == "401")
        {
          print("hfdjfkdjfkdfjdkfjdkfjdkf") ;
          yield ErrorLoginStates("401");
          return;
        }

      else if(accessToken.accessToken?.accessToken == "400")
        {
          print("herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr") ;
          yield ErrorLoginStates("400");
          return;
        }
      // await Code.saveData('token', accessToken.accessToken!.accessToken!);
      // await Code.saveDataLogin('isLogin', true);
      print("yaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      yield SuccessLoginStates("Login is successfully done",
          accessToken.accessToken!.accessToken, true);
    }
  }

// Storing data in SharedPreferences
}
