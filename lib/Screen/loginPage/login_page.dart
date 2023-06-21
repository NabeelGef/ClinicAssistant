import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/event.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../../repository/login_repo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  String _numberInput="" ;
  String _passwordInput="" ;
  String _trimPassword="" ;
  String _trimNumber="" ;
  late SharedPreferences _prefs;

  FocusNode _emailFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  bool _isEmailEmpty = true;

  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _passwordController = TextEditingController();


  /*SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;*/

  /*@override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }
*/

  @override
  initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailEmpty = _emailController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  // Storing data in SharedPreferences
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) =>
          LoginBloc(InitialLoginStates(), LoginRepository()),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Font.urlImage + 'background.png'),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover
              )
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50) ,
                bottomLeft: Radius.circular(50),
              ),
              color: Coloring.primary,
            ),
            width: Sizer.getWidth(context),
            height: Sizer.getHeight(context)/15,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              endDrawer: Code.DrawerNative(context, _scaffoldKey), ////////////
              body: LoginBody(context)),
        ],
      ),
    );
  }

  //Make Body
  Widget LoginBody(BuildContext contextLogin) {
    return SafeArea(
      child: Form(
        key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // MyAppBar(contextLogin),
                Image.asset(
                  height: 185.h,
                  width: 185.w,
                  Font.urlImage + 'logo.png',
                ),

                Container(
                  width: 280.w,
                  height: 264.h,
                  decoration: BoxDecoration(
                      color: Coloring.loginMainContainer,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 1.3.w, color: Coloring.primary)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
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
                          //key: _numberFormKey,
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'أدخل الرقم الخاص بك من فضلك!!';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _numberInput = value! ;
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                            border: InputBorder.none,
                            hintText: "رقم الهاتف",
                          ),
                          style: TextStyle(fontSize: 17.sp),

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
                            if (value == null || value.isEmpty) {
                              return 'أدخل كلمة المرور من فضلك';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _passwordInput = value!;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 6, horizontal: 23),
                            labelText: "كلمة المرور",
                            labelStyle: TextStyle(
                            )
                          ),
                          style: TextStyle(fontSize: 17.sp),
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(height: 7.h),
                      InkWell(
                        onTap: ()
                        {
                          RouterNav.fluroRouter.navigateTo(contextLogin, "/test") ;
                        },
                        child: Text(
                          "هل نسيت كلمة المرور؟",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Coloring.loginWhite,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),

                      SizedBox(
                        width: 218.w,
                        height: 43.h,
                        child: BlocConsumer<LoginBloc, LoginStates>(
                            listener: (BuildContext context, LoginStates state) {
                          if (state is SuccessLoginStates)  {
                            saveData('login', 'true') ;
                            RouterNav.fluroRouter.navigateTo(context, RouteName.Home);
                          }
                          if (state is LoadingLoginStates) {
                            Code.showLoadingDialog(context);
                          }
                        }, builder: (BuildContext context, LoginStates state) {
                          return ElevatedButton(
                            onPressed: () async {
                              _login(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Coloring.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(230),
                              ),
                            ),
                            child: const Text("تسجيل الدخول"),
                          );
                        }),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(
                              "إنشاء حساب ",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Coloring.loginWhite,
                                fontStyle: FontStyle.italic
                              ),
                            ),
                            onTap: ()
                            {
                              RouterNav.fluroRouter.navigateTo(contextLogin, RouteName.signup) ;
                            },
                          ),

                          Text("ليس لديك حساب؟ اضغط على" , style: TextStyle(fontSize: 11.sp),),

                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  //Login code
  void _login(BuildContext contextLogin) async {
    //get the email from here
    final email = _emailController.text;
    final password = _passwordController.text;
    _trimNumber = _numberInput.trim() ;
    _trimPassword = _passwordInput.trim() ;


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
                  }




      } else {
        print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
      }
    //وضع شرط هنا أنه عند تأكيد تسجيل الدخول سوف يتم الذهاب للواجهة الرئيسية
  }

  //Make AppBar
  MyAppBar(BuildContext context) {
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
  }
}
