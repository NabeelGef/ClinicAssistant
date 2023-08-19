import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Screen/check_signup/bloc/bloc.dart';
import 'package:clinicassistant/Screen/check_signup/bloc/event.dart';
import 'package:clinicassistant/Screen/check_signup/bloc/states.dart';
import 'package:clinicassistant/repository/check_signup_repo.dart';
import 'package:clinicassistant/repository/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../signup2/bloc/bloc.dart';
import '../signup2/bloc/event.dart';
import '../signup2/bloc/states.dart';

class CheckSignUp extends StatefulWidget {
  final String phoneNumberFromSignUp;
  final String patientId;
  final SignUp2DataSend signUp2DataSend;
  const CheckSignUp(
      {Key? key,
      required this.phoneNumberFromSignUp,
      required this.patientId,
      required this.signUp2DataSend})
      : super(key: key);

  @override
  State<CheckSignUp> createState() => _CheckSignUpState();
}

class _CheckSignUpState extends State<CheckSignUp> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.phoneNumberFromSignUp);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                CheckSignUpBloc(CheckSignUpRepository())),
        BlocProvider<SignUp2Bloc>(
            create: (BuildContext context) => SignUp2Bloc(SignUp2Repository()))
      ],
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Font.urlImage + 'background.png'),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              color: Coloring.primary,
            ),
            width: Sizer.getWidth(context),
            height: Sizer.getHeight(context) / 15,
          ),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              endDrawer: Code.DrawerNative(context, _scaffoldKey), ////////////
              body: CheckSignUpBody(context)),
        ],
      ),
    );
  }

  //Make Body
  Widget CheckSignUpBody(BuildContext contextCheckSignUp) {
    return BlocConsumer<SignUp2Bloc, SignUp2States>(
      builder: (context, state) {
        return Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MyAppBar(contextLogin),

                //This is the logo
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: 260.w,
                      height: 364.h,
                      decoration: BoxDecoration(
                          color: Coloring.loginMainContainer,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1.3.w, color: Coloring.primary)),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.sp,
                          ),
                          Container(
                            child: Text(
                              "OTP تحقق ",
                              style: TextStyle(
                                color: Coloring.loginWhite,
                                fontSize: 18.sp,
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 42),
                          ),
                          Container(
                            child: Text(
                              "لقد ارسلنا رسالة تتضمن رمزاً إلى الرقم",
                              style: TextStyle(
                                  color: Coloring.loginWhite,
                                  fontSize: 15.sp,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: Text(
                              "+963  " + widget.phoneNumberFromSignUp,
                              style: TextStyle(
                                  color: Coloring.loginWhite,
                                  fontSize: 18.sp,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          OtpTextField(
                            numberOfFields: 5,
                            borderColor: Coloring.loginWhite,
                            focusedBorderColor: Coloring.primary,
                            //set to true to show as box or false to show as dash
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            filled: true,
                            decoration: InputDecoration(

                                /*enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25)
                         )*/
                                ),
                            fillColor: Coloring.loginWhite,
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              code = verificationCode;
                            }, // end onSubmit
                          ),
                          SizedBox(height: 10.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  "إعادة الإرسال  ",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 15.sp,
                                      color: Coloring.loginWhite,
                                      fontStyle: FontStyle.italic),
                                ),
                                onTap: () {
                                  SignUp2Bloc.get(context)
                                      .add(widget.signUp2DataSend);
                                },
                              ),
                              Text("ألم يصلك الرمز ؟ ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 13.sp,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          makeConnection(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, bottom: 280),
                      child: Image.asset(
                        alignment: Alignment.topRight,
                        height: 244.h,
                        width: 378.w,
                        Font.urlImage + 'lock_signup.png',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is LoadingSignUp2States) {
          Code.showLoadingDialog(context);
        } else if (state is ErrorSignUp2States) {
          Navigator.pop(context);
          print("Error is Otp : ${state.errorMessage}");
        } else {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Coloring.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text('تمّ إعادة الإرسال بنجاح',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Coloring.loginWhite,
                      fontFamily: Font.fontfamily)),
            ),
          );
        }
      },
    );
  }

  Widget makeConnection() {
    return BlocConsumer<CheckSignUpBloc, CheckSignUpStates>(
        listener: (BuildContext context, CheckSignUpStates state) {
      if (state is LoadingCheckSignUpStates) {
        print("Loading...");
        Code.showLoadingDialog(context);
      } else if (state is ErrorCheckSignUpStates) {
        Navigator.pop(context);
        Code.showError(context);
      }
      if (state is SuccessCheckSignUpStates) {
        RouterNav.fluroRouter.navigateTo(context, RouteName.login);
      }
    }, builder: (BuildContext context, CheckSignUpStates state) {
      return Container(
        width: Sizer.getWidth(context) / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Coloring.secondary),
        child: MaterialButton(
          onPressed: () {
            CheckSignUpBloc.get(context).add(CheckSignUpDataSend(
                patientId: widget.patientId, verificationCode: code));
          },
          child: Text("تأكيد",
              style: TextStyle(
                  color: Coloring.loginWhite,
                  fontSize: 18.sp,
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold)),
        ),
      );
    });
  }

  //Login code
  void _login(BuildContext contextLogin) async {
    //get the email from here
/*
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if(_trimPassword.isNotEmpty || _trimNumber.isNotEmpty)
      {
        showDialog(
          context: contextLogin,
          builder: (_) =>
              AlertDialog(
                title: Text('خطأ أثناء الإدخال'),
                content: Text('لا تقم بإدخال فراغات فقط في احد الخاناتين من فضلك'),
              ),

        );
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(contextLogin).pop();

        });
      }else
      {
        // Send data to server or do something with input value
        LoginBloc.get(contextLogin)
            .add(LoginDataEntry(email: email, password: password));
      }*/
  }
  //وضع شرط هنا أنه عند تأكيد تسجيل الدخول سوف يتم الذهاب للواجهة الرئيسية
}

  //Make AppBar
/*  MyAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: Sizer.getHeight(context) / 25,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        InkWell(
            onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(bottom: 11),
                child: Icon(Icons.menu,
                    size: Sizer.getTextSize(context, 0.1),
                    color: Coloring.primary)))
      ],
    );
  }*/

