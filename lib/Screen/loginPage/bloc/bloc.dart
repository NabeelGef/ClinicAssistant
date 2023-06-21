import 'package:clinicassistant/Constant/code.dart';
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

      AccessToken accessToken =
          await _loginRepository.loginRepo(events.email, events.password);
      print(accessToken.accessToken?.accessToken);
      await Code.saveData('token', accessToken.accessToken!.accessToken!);
      await Code.saveDataLogin('isLogin', true);
      yield SuccessLoginStates("Login is successfully done");
    }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل
  }

// Storing data in SharedPreferences
}
