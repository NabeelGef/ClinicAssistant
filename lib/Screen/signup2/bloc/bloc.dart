import 'dart:math';

import 'package:clinicassistant/Screen/signup2/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/signup_post.dart';
import '../../../repository/signup_repo.dart';
import 'event.dart';

class SignUp2Bloc extends Bloc<SignUp2Events , SignUp2States>
{
  SignUp2Repository _signUp2Repository ;
  SignUp2Bloc(super.initialState , this._signUp2Repository);

  static SignUp2Bloc get(BuildContext context) => BlocProvider.of(context) ;

  @override
  Stream <SignUp2States> mapEventToState (SignUp2Events events) async*
  {
    if(events is SignUp2DataSend)
    {
      yield LoadingSignUp2States();

      //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

      //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية

      SignUpPost? signUpPost = await _signUp2Repository.signUpRepo( events.firstName! , events.lastName! , events.userName! , events.phoneNumber! , events.password! , events.day! , events.month! , events.year! ,events.gender!) ;
     // print(accessToken.accessToken?.accessToken);
      yield SuccessSignUp2States(signUpPost!.patientId!);
    }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل

  }
}