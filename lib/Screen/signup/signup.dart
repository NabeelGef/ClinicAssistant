import 'package:clinicassistant/Screen/signup/bloc/bolc.dart';
import 'package:clinicassistant/Screen/signup/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String _firstNameInput = "";
  String _lastNameInput = "";
  String _userNameInput = "";
  String _passwordInput = "";
  String _checkPasswordInput = "";
  String _trimFirstName = "";
  String _trimLastName = "";
  String _trimPassword = "";
  String _trimUserName = "";
  String _trimCheckPassword = "";

  FocusNode _emailFocusNode = FocusNode();
  bool _isEmailEmpty = true;

  FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _checkPasswordController = TextEditingController();
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
  Widget SignUpBody(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MyAppBar(contextLogin),
              Container(
                height: Sizer.getHeight(context) / 4,
                width: Sizer.getWidth(context) / 1.1,
                child: Image.asset(
                  "${Font.urlImage}logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 15.sp),
              Container(
                width: Sizer.getWidth(context) / 1.2,
                decoration: BoxDecoration(
                    color: Coloring.loginMainContainer,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1.3.w, color: Coloring.primary)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.sp,
                    ),
                    Container(
                      width: Sizer.getWidth(context) / 1.5,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _firstNameController,
                        //focusNode: _emailFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل الاسم الاول من فضلك";
                          return null;
                        },
                        onSaved: (value) {
                          _firstNameInput = value!;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "الاسم الأول",

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
                    SizedBox(height: 10.sp),
                    Container(
                      width: Sizer.getWidth(context) / 1.5,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _lastNameController,
                        //focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل الاسم الاخير من فضلك";

                          return null;
                        },
                        onSaved: (value) {
                          _lastNameInput = value!;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "الاسم الاخير ",
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
                    /*SizedBox(height: 10.h),
                    Container(
                      width: Sizer.getWidth(context) / 1.5,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _userNameController,
                        // focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل اسم المستخدم من فضلك";
                          return null;
                        },
                        onSaved: (value) {
                          _userNameInput = value!;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "اسم المستخدم ",
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
                    ),*/
                    SizedBox(height: 10.sp),
                    Container(
                      width: Sizer.getWidth(context) / 1.5,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _passwordController,
                        //  focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل كلمة المرور من فضلك";
                          return null;
                        },
                        onSaved: (value) {
                          _passwordInput = value!;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "كلمة المرور",
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
                    SizedBox(height: 10.sp),
                    Container(
                      width: Sizer.getWidth(context) / 1.5,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _checkPasswordController,
                        //focusNode: _passwordFocusNode,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "أدخل كلمة المرور من فضلك";

                          return null;
                        },
                        onSaved: (value) {
                          _checkPasswordInput = value!;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "تأكيد كلمة المرور",
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
                    SizedBox(height: 10.sp),
                    BlocConsumer<SignUpBloc, SignUpStates>(
                        listener: (BuildContext context, SignUpStates state) {
                      if (state is SuccessSignUpStates) {}
                    }, builder: (BuildContext context, SignUpStates state) {
                      return Container(
                        width: Sizer.getWidth(context) / 1.5,
                        height: Sizer.getHeight(context) / 15,
                        child: ElevatedButton(
                            onPressed: () async {
                              //go to the next sign up screen with sending the input data
                              signUpTo(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Coloring.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "استمرار",
                              style: TextStyle(
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            )),
                      );
                    }),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            RouterNav.fluroRouter.navigateTo(context,
                            RouteName.login);
                            },
                            child: Text(
                          "تسجيل الدخول ",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily,
                              color: Coloring.loginWhite,
                              fontStyle: FontStyle.italic),
                        )),
                        Text(
                          "لديك حساب بالفعل؟ اضغط على",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
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

  void signUpTo(BuildContext contextSignUp) {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final userName = _userNameController.text;
    final password = _passwordController.text;
    final checkPassword = _checkPasswordController.text;

    _trimFirstName = _firstNameInput.trim();
    _trimLastName = _lastNameInput.trim();
    _trimUserName = _userNameInput.trim();
    _trimPassword = _passwordInput.trim();
    _trimCheckPassword = _checkPasswordInput.trim();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //go to the next sign up screen with sending the input data
      /*if(_trimFirstName.isNotEmpty || _trimLastName.isNotEmpty || _trimUserName.isNotEmpty || _trimPassword.isNotEmpty || _trimCheckPassword.isNotEmpty)
      {
        showDialog(
          context: contextSignUp,
          builder: (_) =>
              AlertDialog(
                title: Text('خطأ أثناء الإدخال',style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
                content: Text('لا تقم بإدخال فراغات فقط في احد الخانات من فضلك',style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
              ),
        );
       */ /* Future.delayed(Duration(seconds: 5), () {
          Navigator.of(contextSignUp).pop();
        });*/ /*
      }*/
      //else
      {
        if (_passwordInput != _checkPasswordInput) {
          showDialog(
            context: contextSignUp,
            builder: (_) => AlertDialog(
              title: Text('خطأ أثناء الإدخال',
                  style: TextStyle(
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
              content: Text('يجب أن تكون كلمة السر والتأكيد نفسها',
                  style: TextStyle(
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
            ),
          );
          /* Future.delayed(Duration(seconds: 5), () {
            Navigator.of(contextSignUp).pop();

          });*/
        } else {
          //here should i put the confirm for the user that is the information can not be
          //changes in the future ,, so are you sure?
          showDialog(
            context: contextSignUp,
            builder: (_) => AlertDialog(
              title: Text('هل أنت متأكد',
                  style: TextStyle(
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
              content: Text('لن تكون لك القدرة على تعديل البيانات المدخلة',
                  style: TextStyle(
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
              actions: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: Coloring.primary),
                      onPressed: () {
                        //go to the other page
                        RouterNav.fluroRouter.navigateTo(
                            contextSignUp,
                            routeSettings: RouteSettings(arguments: {
                              'receivedFirstName': firstName,
                              'receivedLastName': lastName,
                              'receivedUserName': userName,
                              'receivedPassword': password
                            }),
                            RouteName.signup2 +
                                "/$firstName/$lastName/$userName/$password");
                      },
                      child: Text("تأكيد ",
                          style: TextStyle(
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp))),
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
