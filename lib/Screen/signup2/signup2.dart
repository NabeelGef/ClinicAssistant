import 'dart:io';

import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/signup2/bloc/bloc.dart';
import 'package:clinicassistant/Screen/signup2/bloc/event.dart';
import 'package:clinicassistant/Screen/signup2/bloc/states.dart';

import 'package:clinicassistant/model/user_information.dart';
import 'package:clinicassistant/repository/signup_repo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constant/Route/routename.dart';
import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/font.dart';

class SignUp2 extends StatefulWidget {
  final String receivedFirstName;
  final String receivedLastName;
  final String receivedUserName;
  final String receivedPassword;
  const SignUp2(
      {Key? key,
      required this.receivedFirstName,
      required this.receivedLastName,
      required this.receivedUserName,
      required this.receivedPassword})
      : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  UserInformation? userInformation;
  List<int> years = [];
  List<String> days = [];
  List<String> gender = ["ذكر", "أنثى"];
  List<String> months = [];
  String? selectedDayItem;
  String? selectedMonthItem;
  int? selectedYearItem;
  String? selectedGenderItem;
  String _phoneNumberInput = "";
  String _trimPhoneNumber = "";

  @override
  void initState() {
    super.initState();
    print(widget.receivedFirstName);
    userInformation = UserInformation(
        firstName: widget.receivedFirstName,
        lastName: widget.receivedLastName,
        userName: widget.receivedUserName,
        password: widget.receivedPassword);
    //for format the year list
    for (int i = 2023; i >= 2023 - 90; i--) {
      years.add(i);
    }
    for (int i = 1; i <= 12; i++) {
      if (i < 10)
        months.add("0$i");
      else
        months.add("$i");
    }
    for (int i = 1; i <= 31; i++) {
      if (i < 10)
        days.add("0$i");
      else
        days.add("$i");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return BlocProvider<SignUp2Bloc>(
      create: (BuildContext context) => SignUp2Bloc(SignUp2Repository()),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Font.urlImage + 'background.png'),
                    fit: BoxFit.cover)),
          ), ///////////////
          Scaffold(
              resizeToAvoidBottomInset: false,
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
    return Center(
      child: Form(
        key: _formKey,
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
                    height: 50.sp,
                  ),
                  Container(
                    width: Sizer.getWidth(context) / 1.5,
                    alignment: Alignment.center,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "أدخل رقم الهاتف من فضلك !!";
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumberInput = value!;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "رقم الهاتف",
                        errorStyle: TextStyle(fontSize: 15.sp),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.red),
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
                    alignment: Alignment.center,
                    child: Text(
                      ":تاريخ الميلاد",
                      style: TextStyle(
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Coloring.loginWhite),
                    ),
                  ),
                  SizedBox(height: 15.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'سنة',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: years
                              .map((item) => DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      "$item",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedYearItem,
                          onChanged: (value) {
                            setState(() {
                              selectedYearItem = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 81,
                            padding: const EdgeInsets.only(left: 21, right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Coloring.loginWhite,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            iconSize: 22,
                            iconEnabledColor: Colors.indigo,
                            iconDisabledColor: Colors.indigo,
                          ),
                          dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              )),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'شهر',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: months
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      "$item",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedMonthItem,
                          onChanged: (value) {
                            setState(() {
                              selectedMonthItem = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 83,
                            padding: const EdgeInsets.only(left: 21, right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Coloring.loginWhite,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            iconSize: 22,
                            iconEnabledColor: Colors.indigo,
                            iconDisabledColor: Colors.indigo,
                          ),
                          dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              )),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'يوم',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: days
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      "$item",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedDayItem,
                          onChanged: (value) {
                            setState(() {
                              selectedDayItem = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 80,
                            padding: const EdgeInsets.only(left: 21, right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Coloring.loginWhite,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            iconSize: 22,
                            iconEnabledColor: Colors.indigo,
                            iconDisabledColor: Colors.indigo,
                          ),
                          dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              elevation: 8,
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              )),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text("الجنس ",
                        style: TextStyle(
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Coloring.loginWhite)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'اختر',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: gender
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedGenderItem,
                        onChanged: (value) {
                          setState(() {
                            selectedGenderItem = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 40,
                          width: 80,
                          padding: const EdgeInsets.only(left: 21, right: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Coloring.loginWhite,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                          ),
                          iconSize: 22,
                          iconEnabledColor: Colors.indigo,
                          iconDisabledColor: Colors.indigo,
                        ),
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            elevation: 8,
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            )),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 218.w,
                    height: 43.h,
                    child: BlocConsumer<SignUp2Bloc, SignUp2States>(
                        listener: (BuildContext context, SignUp2States state) {
                      if (state is SuccessSignUp2States) {
                        RouterNav.fluroRouter.navigateTo(
                            context,
                            routeSettings: RouteSettings(arguments: {
                              'phoneNumberFromSignUp': _phoneNumberInput,
                            }),
                            RouteName.checkSignUp +
                                "/$_phoneNumberInput" +
                                "/${state.successMessage}");
                      }

                      if (state is LoadingSignUp2States) {
                        print("Loading...");
                        Code.showLoadingDialog(context);
                      } else if (state is ErrorSignUp2States) {
                        Navigator.pop(context);

                        print("am in the  error sign up state");

                        if (state.errorMessage == "Error Number Form") {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('خطأ في إدخال الرقم'),
                              content: Text(
                                  'تأكد من أن الرقم يبدأ ب 09 ويتكون من 10 ارقام'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state.errorMessage == "Error number exist") {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('خطأ في الرقم'),
                              content:
                                  Text('الرقم المدخل مستخدم من قبل شخص آخر'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    }, builder: (BuildContext context, SignUp2States state) {
                      return ElevatedButton(
                        onPressed: () async {
                          //go to the next sign up screen with sending the input data
                          signUp2To(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Coloring.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(230),
                          ),
                        ),
                        child: Text("إنشاء الحساب",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily,
                            )),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          RouterNav.fluroRouter
                              .navigateTo(context, RouteName.login);
                        },
                        child: Text(
                          "تسجيل دخول ",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily,
                              color: Coloring.loginWhite,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Text(
                        "لديك حساب بالفعل؟ اضغط على",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: Font.fontfamily,
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
    );
  }

  void signUp2To(BuildContext contextSignUp) {
    _trimPhoneNumber = _phoneNumberInput.trim();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (selectedDayItem == null ||
          selectedMonthItem == null ||
          selectedMonthItem == null ||
          selectedGenderItem == null) {
        showDialog(
          context: contextSignUp,
          builder: (_) => AlertDialog(
            title: Text('خطأ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            content: Text('يجب إدخال كافة الحقول من فضلك',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(contextSignUp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Coloring.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(230),
                    ),
                  ),
                  child: Text("موافق",
                      style: TextStyle(
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp)),
                ),
              ),
            ],
          ),
        );
      }

      //go to the next sign up screen with sending the input data
      /*if (_trimPhoneNumber.isEmpty) {
        // هنا وضع شرط أنه لا يوجد فراغات في الحقل وعند الدخول لهنا فإنه يوجد فراغات
        showDialog(
          context: contextSignUp,
          builder: (_) => AlertDialog(
            title: Text('خطأ أثناء الإدخال',
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            content: Text('لا تقم بإدخال فراغات فقط مكان الرقم من فضلك',
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
          ),
        );
        */ /* Future.delayed(Duration(seconds: 5), () {
          Navigator.of(contextSignUp).pop();

        });*/ /*

        // this is for the right input
      }*/ /*else*/
      //here should i put the confirm for the user that is the information can not be
      //changes in the future ,, so are you sure?
      else {
        showDialog(
          context: contextSignUp,
          builder: (_) => AlertDialog(
            title: Text('هل أنت متأكد',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            content: Text('لن تكون لك القدرة على تعديل البيانات المدخلة',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    //تابع ارسال البيانات للداتا بيز
                    SignUp2Bloc.get(contextSignUp).add(SignUp2DataSend(
                        firstName: widget.receivedFirstName,
                        lastName: widget.receivedLastName,
                        userName: widget.receivedUserName,
                        phoneNumber: _phoneNumberInput,
                        password: widget.receivedPassword,
                        year: selectedYearItem,
                        month: selectedMonthItem,
                        day: selectedDayItem,
                        gender: selectedGenderItem));
                    Navigator.pop(contextSignUp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Coloring.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(230),
                    ),
                  ),
                  child: Text("إنشاء الحساب",
                      style: TextStyle(
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp)),
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}



/*
 Container(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.person,
                          size: 80,
                        )
                      : null,
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    _showPicker(contextLogin);
                  },
                ),
              )

Future getImage(ImageSource source) async {
  final pickedFile = await ImagePicker().getImage(source: source);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}

void _showPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

 */