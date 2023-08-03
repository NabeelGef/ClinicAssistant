import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/event.dart';
import 'package:clinicassistant/Screen/loginPage/bloc/states.dart';
import 'package:clinicassistant/blocShared/event.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/repository/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  String _numberInput = "";
  String _passwordInput = "";
  String _trimPassword = "";
  String _trimNumber = "";
  FocusNode _emailFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  //bool _isEmailEmpty = true;

  bool _obscureText = true;
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

  // @override
  // initState() {
  //   super.initState();
  //   _emailFocusNode.addListener(() {
  //     setState(() {
  //       _isEmailEmpty = _emailController.text.isEmpty;
  //     });
  //   });
  // }

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
      create: (BuildContext context) => LoginBloc(LoginRepository()),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Font.urlImage + 'background.png'),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover)),
          ),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              endDrawer: Code.DrawerNative(context, _scaffoldKey), ////////////
              body: LoginBody(context)),
        ],
      ),
    );
  }

  //Make Body
  Widget LoginBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
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
        ),
        Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Sizer.getHeight(context) / 4,
                  width: Sizer.getWidth(context) / 1.1,
                  child: Image.asset(
                    "${Font.urlImage}logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10.sp),
                Container(
                  width: Sizer.getWidth(context) / 1.2,
                  decoration: BoxDecoration(
                      color: Coloring.loginMainContainer,
                      borderRadius: BorderRadius.circular(25),
                      border:
                          Border.all(width: 1.3.w, color: Coloring.primary)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.sp,
                      ),
                      Container(
                        width: Sizer.getWidth(context) / 1.5,
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'أدخل الرقم الخاص بك من فضلك';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _numberInput = value!;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "رقم الهاتف",
                            errorStyle: TextStyle(fontSize: 15.sp),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(25.sp)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                          ),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(height: 25.sp),
                      Container(
                        width: Sizer.getWidth(context) / 1.5,
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
                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              color: Coloring.primary,
                            ),
                            filled: true,
                            hintText: "كلمة المرور ",
                            errorStyle: TextStyle(fontSize: 15.sp),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(25.sp)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.sp)),
                          ),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(height: 7.sp),
                      InkWell(
                        onTap: () {
                          RouterNav.fluroRouter
                              .navigateTo(context, RouteName.forgetPassword);
                        },
                        child: Text(
                          "هل نسيت كلمة المرور؟",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: Font.fontfamily,
                            color: Coloring.loginWhite,
                          ),
                        ),
                      ),
                      BlocConsumer<LoginBloc, LoginStates>(listener:
                          (BuildContext context, LoginStates state) async {
                        if (state is LoadingLoginStates) {
                          print("Loading...");
                          Code.showLoadingDialog(context);
                        } else if (state is SuccessLoginStates) {
                          Navigator.pop(context);

                          context
                              .read<SharedBloc>()
                              .add(SaveDataToken(token: state.token));
                          context
                              .read<SharedBloc>()
                              .add(SaveDataLogin(isLogin: state.isLogin));

                          RouterNav.fluroRouter.navigateTo(
                              context,
                              routeSettings: RouteSettings(arguments: {}),
                              RouteName.Home);
                        } else if (state is ErrorLoginStates) {
                          Navigator.pop(context);
                          if (state.errorMessage == "401") {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('خطأ في البيانات',
                                    style: TextStyle(
                                        color: Coloring.loginWhite,
                                        fontFamily: Font.fontfamily)),
                                content: Text(
                                    'تأكد من رقمك وكلمة السر قبل الإدخال من فضلك',
                                    style: TextStyle(
                                        color: Coloring.loginWhite,
                                        fontFamily: Font.fontfamily)),
                                backgroundColor: Coloring.primary,
                              ),
                            );
                          } else if (state.errorMessage == "400") {
                            Code.showError(context);
                          }
                        }
                      }, builder: (BuildContext context, LoginStates state) {
                        return Container(
                          height: Sizer.getHeight(context) / 15,
                          width: Sizer.getWidth(context) / 1.5,
                          child: ElevatedButton(
                            onPressed: () async {
                              _login(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Coloring.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp)),
                          ),
                        );
                      }),
                      SizedBox(height: 10.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(
                              "إنشاء حساب ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.sp,
                                  color: Coloring.loginWhite,
                                  fontStyle: FontStyle.italic),
                            ),
                            onTap: () {
                              RouterNav.fluroRouter
                                  .navigateTo(context, RouteName.signup);
                            },
                          ),
                          Text("ليس لديك حساب؟ اضغط على",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 13.sp,
                                  fontStyle: FontStyle.italic)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Login code
  void _login(BuildContext contextLogin) async {
    //get the email from here
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _trimNumber = _numberInput.trim();
      _trimPassword = _passwordInput.trim();

      print("the empty one $_trimPassword" + "the empty one $_trimNumber");

      //هذا الشرط يعمل فقط في حالة كان الإدخال فقط فراغات
      if (_trimPassword.isEmpty || _trimNumber.isEmpty) {
        showDialog(
          context: contextLogin,
          builder: (_) => AlertDialog(
            title: Text('خطأ أثناء الإدخال'),
            content: Text('لا تقم بإدخال فراغات فقط في احد الخاناتين من فضلك'),
          ),
        );
        Future.delayed(Duration(seconds: 5), () {});
      } else {
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
