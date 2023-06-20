import 'dart:io';

import 'package:clinicassistant/Screen/loginPage/bloc/event.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/states.dart';
import 'package:clinicassistant/model/login_token.dart';
import 'package:clinicassistant/repository/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginBloc extends Bloc<LoginEvents , LoginStates>
{
  LoginRepository _loginRepository;
  LoginBloc(super.initialState , this._loginRepository);

  static LoginBloc get(BuildContext context) => BlocProvider.of(context);

  //سوف يأخذ حدث من هنا ويعيد قناة من الحالات
  @override
  Stream <LoginStates> mapEventToState (LoginEvents events) async*
  {
    if(events is LoginDataEntry)
      {
        yield LoadingLoginStates();

        //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

        //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية

        AccessToken accessToken = await _loginRepository.loginRepo( events.email , events.password) ;
        print(accessToken.accessToken?.accessToken);
        await saveData('token', accessToken.accessToken!.accessToken!) ;
        yield SuccessLoginStates("Login is successfully done");
      }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل

  }


// Storing data in SharedPreferences
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Retrieving data from SharedPreferences
  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}