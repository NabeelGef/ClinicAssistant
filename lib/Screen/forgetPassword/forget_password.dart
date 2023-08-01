import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/forgetPassword/bloc/bloc.dart';
import 'package:clinicassistant/Screen/forgetPassword/bloc/event.dart';
import 'package:clinicassistant/Screen/forgetPassword/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formKeyDialog = GlobalKey();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String? code;
  String? password1;
  String? password2;

  String? numberPhone;
  ForgetPasswordBloc forgetPasswordBloc = ForgetPasswordBloc(
      ForgetPasswordState(
          getPatientId: GetPatientId(patientId: null, error: ""),
          verifyState: VerifyState(message: null, error: "")));
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("${Font.urlImage}background.png"),
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
          body: BodyForget(context),
        ),
      ],
    );
  }

  BodyForget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "${Font.urlImage}lock_signup.png",
          ),
          Container(
            height: Sizer.getHeight(context) / 3,
            width: Sizer.getWidth(context) / 1.2,
            decoration: BoxDecoration(
              color: Coloring.loginMainContainer,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("يجب تأكيد رقم الهاتف للتحقق من حسابك",
                      style: TextStyle(
                          fontSize: 15.r,
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.all(15.r),
                    child: TextFormField(
                      maxLength: 10,
                      style: TextStyle(
                          color: Coloring.primary,
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ملئ الحقل";
                        } else if (value.length < 10) {
                          return "يجب أن يكون 10 أرقام ";
                        }
                        return null;
                      },
                      cursorColor: Coloring.primary,
                      onSaved: (newValue) {
                        numberPhone = newValue!;
                      },
                      decoration: InputDecoration(
                        counterStyle: TextStyle(
                            color: Coloring.primary,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold),
                        labelText: "أدخل رقم الهاتف",
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(15.r),
                        suffixIcon: Icon(Icons.phone, color: Coloring.primary),
                        errorStyle: TextStyle(
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: TextStyle(
                            color: Coloring.primary,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        forgetPasswordBloc
                            .add(AddNumberPhone(numberPhone: numberPhone!));
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocBuilder<ForgetPasswordBloc,
                                      ForgetPasswordState>(
                                  bloc: forgetPasswordBloc,
                                  builder: (context, state) {
                                    if (state.getPatientId.patientId == null) {
                                      if (state.getPatientId.error.isEmpty) {
                                        return AlertDialog(
                                          backgroundColor: Coloring.primary2,
                                          content: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return AlertDialog(
                                          backgroundColor: Coloring.primary2,
                                          content: Text(
                                            "خطأ في الرقم",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font.fontfamily),
                                          ),
                                        );
                                      }
                                    } else {
                                      return AlertDialog(
                                        backgroundColor: Coloring.primary2,
                                        title: Text(
                                            ": لقد تمّ إرسال رمز إلى  \n ${numberPhone}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font.fontfamily)),
                                        content: SingleChildScrollView(
                                          child: Form(
                                            key: _formKeyDialog,
                                            child: Column(
                                              children: [
                                                OtpTextField(
                                                  numberOfFields: 5,
                                                  borderColor:
                                                      Coloring.loginWhite,
                                                  cursorColor: Coloring.primary,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  styles: [
                                                    TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                  onSubmit: (value) {
                                                    code = value;
                                                  },
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ),
                                                SizedBox(
                                                  height: 15.r,
                                                ),
                                                Text(
                                                    ":أدخل كلمة المرور الجديدة  ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font.fontfamily)),
                                                Container(
                                                  child: TextFormField(
                                                    controller: t1,
                                                    obscureText: true,
                                                    maxLength: 20,
                                                    style: TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "يجب ملئ الحقل";
                                                      } else if (value.length <
                                                          5) {
                                                        return "يجب أن تتكون من خمسة رموز ";
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        Coloring.primary,
                                                    onSaved: (newValue) {
                                                      password1 = newValue!;
                                                    },
                                                    decoration: InputDecoration(
                                                      counterStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      hintText: "كلمة المرور",
                                                      contentPadding:
                                                          EdgeInsets.all(10.r),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      suffixIcon: Icon(
                                                          Icons.key,
                                                          color:
                                                              Coloring.primary),
                                                      errorStyle: TextStyle(
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Coloring.primary,
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.r,
                                                ),
                                                Text(
                                                    ":تأكيد كلمة المرور الجديدة  ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font.fontfamily)),
                                                Container(
                                                  child: TextFormField(
                                                    controller: t2,
                                                    obscureText: true,
                                                    maxLength: 20,
                                                    style: TextStyle(
                                                        color: Coloring.primary,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "يجب ملئ الحقل";
                                                      } else if (value.length <
                                                          5) {
                                                        return "يجب أن تتكون من خمسة رموز ";
                                                      } else if (t1.text !=
                                                          t2.text) {
                                                        return "لايوجد تطابق";
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        Coloring.primary,
                                                    onSaved: (newValue) {
                                                      password2 = newValue!;
                                                    },
                                                    decoration: InputDecoration(
                                                      counterStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      hintText:
                                                          " تأكيد كلمة المرور",
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.all(10.r),
                                                      suffixIcon: Icon(
                                                          Icons.key,
                                                          color:
                                                              Coloring.primary),
                                                      errorStyle: TextStyle(
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Coloring.primary,
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (_formKeyDialog
                                                        .currentState!
                                                        .validate()) {
                                                      _formKeyDialog
                                                          .currentState!
                                                          .save();
                                                      forgetPasswordBloc
                                                          .add(Verify(
                                                              patientId: state
                                                                  .getPatientId
                                                                  .patientId!,
                                                              code: code!,
                                                              newPassword:
                                                                  password2!));
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            if (state
                                                                    .verifyState
                                                                    .message ==
                                                                null) {
                                                              if (state
                                                                  .verifyState
                                                                  .error
                                                                  .isEmpty) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      Coloring
                                                                          .third,
                                                                  title: Center(
                                                                      child: CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white)),
                                                                );
                                                              } else {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      Coloring
                                                                          .third,
                                                                  title: Center(
                                                                      child: Text(
                                                                          "حدث خطأ يرجى إعادة المحاولة",
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontFamily: Font.fontfamily,
                                                                              fontWeight: FontWeight.bold))),
                                                                );
                                                              }
                                                            } else {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    Coloring
                                                                        .third,
                                                                title: Text(
                                                                  "تمّ تغيير كلمة المرور بنجاح",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          Font
                                                                              .fontfamily,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                content:
                                                                    InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(25.r)),
                                                                    child: Text(
                                                                      "موافق",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: Coloring
                                                                              .primary,
                                                                          fontFamily: Font
                                                                              .fontfamily,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.r,
                                                            vertical: 10.r),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.r),
                                                        color: Colors.white),
                                                    child: Text("تأكيد",
                                                        style: TextStyle(
                                                            fontSize: 15.r,
                                                            color: Coloring
                                                                .primary,
                                                            fontFamily:
                                                                Font.fontfamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                            });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.r, vertical: 10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white),
                      child: Text("تأكيد",
                          style: TextStyle(
                              fontSize: 15.r,
                              color: Coloring.primary,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
