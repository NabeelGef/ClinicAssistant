import 'package:clinicassistant/Screen/signup2/bloc/states.dart';
import 'package:clinicassistant/repository/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';

class SignUp2Bloc extends Bloc<SignUp2Events, SignUp2States> {
  SignUp2Repository _signUp2Repository;
  SignUp2Bloc(this._signUp2Repository) : super(InitialSignUp2States());

  static SignUp2Bloc get(BuildContext context) => BlocProvider.of(context);

  @override
  Stream<SignUp2States> mapEventToState(SignUp2Events events) async* {
    if (events is SignUp2DataSend) {
      yield LoadingSignUp2States();

      //هنا عندما تعود البيانات نقوم بحفظها بالشيرد بريفيرينس

      //بعد الانتهاء من الادخال يجب اعادة بيانات للشاشو وهي نجاح العملية
      var signUpPost = await _signUp2Repository.signUpRepo(
          events.firstName!,
          events.lastName!,
          events.userName!,
          events.phoneNumber!,
          events.password!,
          events.day!,
          events.month!,
          events.year!,
          events.gender!);
      // print(accessToken.accessToken?.accessToken);

      if (signUpPost?.patientId == "يجب أن يكون الرقم من 10 خانات ويبدأ ب 09") {
        yield ErrorSignUp2States("Error Number Form");
        return;
      } else if (signUpPost?.patientId == "this phone number already exist") {
        yield ErrorSignUp2States("Error number exist");
        return;
      }

      yield SuccessSignUp2States(signUpPost!.patientId!);
    }
    // هنا اكتب الاحداث التي من المفترض أن تحدث مثلا ارسال بيانات التسجيل
  }
}
