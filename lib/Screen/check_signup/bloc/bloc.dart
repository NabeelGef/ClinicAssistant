import 'package:clinicassistant/Screen/check_signup/bloc/states.dart';
import 'package:clinicassistant/repository/check_signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';

class CheckSignUpBloc extends Bloc<CheckSignUpEvents, CheckSignUpStates> {
  CheckSignUpRepository _checkSignUpRepository;
  CheckSignUpBloc(this._checkSignUpRepository)
      : super(InitialCheckSignUpStates());

  static CheckSignUpBloc get(BuildContext context) => BlocProvider.of(context);

  @override
  Stream<CheckSignUpStates> mapEventToState(CheckSignUpEvents events) async* {
    if (events is CheckSignUpDataSend) {
      yield LoadingCheckSignUpStates();

      //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

      //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية
      try {
        String? successMessage = await _checkSignUpRepository.checkSignUpRepo(
            events.patientId!, events.verificationCode!);
        yield SuccessCheckSignUpStates(successMessage!);
      } catch (e, stack) {
        print("Error In Check OTP is $e in $stack");
        yield ErrorCheckSignUpStates();
      }
    }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل
  }
}
