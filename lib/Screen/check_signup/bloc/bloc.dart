import 'dart:math';

import 'package:clinicassistant/Screen/check_signup/bloc/states.dart';
import 'package:clinicassistant/Screen/signup2/bloc/states.dart';
import 'package:clinicassistant/repository/check_signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';

class CheckSignUpBloc extends Bloc<CheckSignUpEvents , CheckSignUpStates>
{
  CheckSignUpRepository _checkSignUpRepository ;
  CheckSignUpBloc(super.initialState , this._checkSignUpRepository);

  static CheckSignUpBloc get(BuildContext context) => BlocProvider.of(context) ;

  @override
  Stream <CheckSignUpStates> mapEventToState (CheckSignUpEvents events) async*
  {
    if(events is CheckSignUpDataSend)
    {
      yield LoadingCheckSignUpStates();

      //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

      //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية

      String? successMessage = _checkSignUpRepository.convert(events.patientId! , events.verificationCode!) ;
      yield SuccessCheckSignUpStates(successMessage!);
    }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل

  }
}