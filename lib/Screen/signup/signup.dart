import 'dart:io';

import 'package:clinicassistant/Screen/signup/bloc/bolc.dart';
import 'package:clinicassistant/Screen/signup/bloc/states.dart';
import 'package:clinicassistant/model/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constant/Route/routename.dart';
import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  String _firstNameInput="" ;
  String _lastNameInput="" ;
  String _userNameInput="" ;
  String _passwordInput="" ;
  String _checkPasswordInput="" ;
  String _trimFirstName="" ;
  String _trimLastName="" ;
  String _trimPassword="" ;
  String _trimUserName="" ;
  String _trimCheckPassword ="" ;

  FocusNode _emailFocusNode = FocusNode();
  bool _isEmailEmpty = true;

  FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _firstNameController = TextEditingController() ;
  TextEditingController _lastNameController = TextEditingController() ;
  TextEditingController _userNameController = TextEditingController() ;
  TextEditingController _passwordController = TextEditingController() ;
  TextEditingController _checkPasswordController = TextEditingController() ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) => SignUpBloc(InitialSignUpStates()),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Font.urlImage + 'background.png'),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover)),
          ), ///////////////
          Scaffold(
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              endDrawer: Code.DrawerNative(context, _scaffoldKey), ////////////
              body: SignUpBody(context)),
        ],
      ),
    );
  }

  //Make Body
  Widget SignUpBody(BuildContext contextSignUp) {
    return Form(
      key: _formKey,
      child: Center(
        child: Stack(children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // MyAppBar(contextLogin),
              Image.asset(
                height: 165.h,
                width: 165.w,
                Font.urlImage + 'logo.png',
              ),

              Container(
                width: 288.w,
                height: 390.h,
                decoration: BoxDecoration(
                    color: Coloring.loginMainContainer,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1.3.w, color: Coloring.primary)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      width: 223.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _firstNameController,
                        focusNode: _emailFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value!.isEmpty)
                            return "أدخل الاسم الاول من فضلك!!";

                          return null;
                        },
                        onSaved: (value)
                        {
                          _firstNameInput = value! ;
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                          border: InputBorder.none,
                          hintText: "الاسم الأول",
                        ),
                        onTap: () {

                        },
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 223.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Coloring.loginWhite,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: TextFormField(
                        controller: _lastNameController,
                        focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل الاسم الاخير من فضلك!!";

                          return null;
                        },
                        onSaved: (value)
                        {
                          _lastNameInput = value! ;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                          hintText: "الاسم الاخير",
                        ),
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 223.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Coloring.loginWhite,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: TextFormField(
                        controller: _userNameController,
                        focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل اسم المستخدم من فضلك!!";

                          return null;
                        },

                        onSaved: (value)
                        {
                          _userNameInput = value! ;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                          hintText: "اسم المستخدم",
                        ),
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 223.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Coloring.loginWhite,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل كلمة المرور من فضلك!!";

                          return null;
                        },
                        onSaved: (value)
                        {
                          _passwordInput = value!;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                          hintText: "كلمة المرور",
                        ),
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 223.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Coloring.loginWhite,
                        borderRadius: BorderRadius.circular(38),
                      ),
                      child: TextFormField(
                        controller: _checkPasswordController,
                        focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل كلمة المرور من فضلك!!";

                          return null;
                        },

                        onSaved: (value)
                        {
                          _checkPasswordInput = value! ;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                          hintText: "تأكيد كلمة المرور",
                        ),
                        style: TextStyle(fontSize: 17.sp),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 218.w,
                      height: 43.h,
                      child: BlocConsumer<SignUpBloc, SignUpStates>(
                          listener: (BuildContext context, SignUpStates state) {
                        if (state is SuccessSignUpStates) {}
                      }, builder: (BuildContext context, SignUpStates state) {
                        return ElevatedButton(
                          onPressed: () async {
                           //go to the next sign up screen with sending the input data
                            signUpTo(context) ;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Coloring.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(230),
                            ),
                          ),
                          child: const Text("استمرار"),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Text(
                            "تسجيل دخول ",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Coloring.loginWhite,
                                fontStyle: FontStyle.italic),
                          ),
                          onTap: () {},
                        ),
                        Text(
                          "لديك حساب بالفعل؟ اضغط على",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ]),
      ),
    );
  }


  void signUpTo(BuildContext contextSignUp) {
    final firstName = _firstNameController.text ;
    final lastName = _lastNameController.text ;
    final userName = _userNameController.text ;
    final password = _passwordController.text ;
    final checkPassword = _checkPasswordController.text ;

    _trimFirstName = _firstNameInput.trim() ;
    _trimLastName = _lastNameInput.trim() ;
    _trimUserName = _userNameInput.trim() ;
    _trimPassword = _passwordInput.trim() ;
    _trimCheckPassword = _checkPasswordInput.trim() ;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //go to the next sign up screen with sending the input data
      if(_trimFirstName.isNotEmpty || _trimLastName.isNotEmpty || _trimUserName.isNotEmpty || _trimPassword.isNotEmpty || _trimCheckPassword.isNotEmpty)
      {
        showDialog(
          context: contextSignUp,
          builder: (_) =>
              AlertDialog(
                title: Text('خطأ أثناء الإدخال'),
                content: Text('لا تقم بإدخال فراغات فقط في احد الخانات من فضلك'),
              ),

        );
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(contextSignUp).pop();

        });
      }else
      {
        if(_passwordInput != _checkPasswordInput)
        {
          showDialog(
            context: contextSignUp,
            builder: (_) =>
                AlertDialog(
                  title: Text('خطأ أثناء الإدخال'),
                  content: Text('يجب أن تكون كلمة السر والتأكيد نفسها'),
                ),
          );
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(contextSignUp).pop();

          });
        }else
          {
            //here should i put the confirm for the user that is the information can not be
            //changes in the future ,, so are you sure?
            showDialog(
              context: contextSignUp,
              builder: (_) =>
                  AlertDialog(
                    title: Text('هل أنت متأكد'),
                    content: Text('لن تكون لك القدرة على تعديل البيانات المدخلة'),
                    actions: [
                      ElevatedButton(
                          onPressed: ()
                          {
                            //go to the other page
                            RouterNav.fluroRouter.navigateTo(
                                contextSignUp,
                                routeSettings:RouteSettings(
                                    arguments:{
                                      'receivedFirstName' : firstName,
                                      'receivedLastName': lastName,
                                      'receivedUserName' : userName,
                                      'receivedPassword': password
                                    }),
                                RouteName.signup2+"/$firstName/$lastName/$userName/$password"
                            );
                          },
                          child:Text("تأكيد ")
                      ),
                    ],
                  ),
            );
          }
      }

    } else {
      print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    }
  }
}
