import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Code {
//Make a const Drawer in Doctor and clinic page

  static Widget DrawerNative(
      BuildContext context, GlobalKey<ScaffoldState> key) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        //color: Colors.red,
        height: Sizer.getHeight(context) / 1.7,
        width: Sizer.getWidth(context),
        child: Drawer(
          backgroundColor: Coloring.primary3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(children: [
            /*Container(
                  height: Sizer.getHeight(context)/5,
                  child: DrawerHeader(
                    curve: Curves.easeIn,

                    decoration: BoxDecoration(

                        color: Coloring.primary
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 5),
                        Container(
                            alignment: Alignment.center,
                            width: Sizer.getWidth(context)/5,
                            height: Sizer.getWidth(context)/5  ,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat,
                                  image: AssetImage("assets/images/logo.png")),
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.grey[100],
                            ),
                            */ /*child:Center(
                              child: Image(fit: BoxFit.fill
                                   image:AssetImage("assets/images/logo.png"
                                  )),
                            )*/ /*
                        ),
                        SizedBox(width: 10),
                        Text("مساعد العيادات",style: TextStyle(color: Colors.black ,
                            fontFamily: Font.fontfamily ,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),*/

            SizedBox(height: Sizer.getHeight(context) / 20),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  //Close EndDrawer
                  key.currentState!.closeEndDrawer();
                },
                child: Icon(Icons.close,
                    size: Sizer.getTextSize(context, 0.09),
                    color: Colors.white),
              ),
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                //Go To Home
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.home,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("الصّفحة الرّئيسيّة",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Loginpage
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.key,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("تسجيل الدّخول",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                //Go To AboutPage
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("حول النّظام",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Settings
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.settings,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("الإعدادات",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Privacy
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.privacy_tip_outlined,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 10),
                  Text("الخصوصية  وسياسة الاستخدام",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
  //Make a const FloatingPoint in Doctor and clinic page

  static getFloatingPoint(BuildContext context, String path) {
    return Container(
      width: Sizer.getWidth(context) / 8,
      height: Sizer.getWidth(context) / 8,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, path);
        },
        backgroundColor: Coloring.custompurble,
        child: Icon(
          Icons.navigate_next,
          color: Colors.grey,
          size: 50,
        ),
      ),
    );
  }

  //Make a conts AppBar in Doctor and clinic page
  static Widget AppBarProfile(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context){
    return AppBar(
        toolbarHeight: Sizer.getHeight(context) / 6,
          backgroundColor: Coloring.primary,
          leading: InkWell(
            onTap: () {},
            child: Icon(Icons.notifications_none_outlined,
          size: Sizer.getTextSize(context, 0.08), color: Colors.white)),
          actions: [
          InkWell(
              onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
              child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu,
                size: Sizer.getTextSize(context, 0.08),
                color: Colors.white)))
          ],
          centerTitle: true,
            title: Image.asset("${Font.urlImage}logo.png",width: Sizer.getWidth(context)/5,
              height: Sizer.getHeight(context)/5
              ,),
    );
    }
  static Widget AppBarDoctorsAndClinics(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context, bool isDoctor, String hint) {
    return AppBar(
      toolbarHeight: Sizer.getHeight(context) / 6,
      backgroundColor: Coloring.primary,
      leading: InkWell(
          onTap: () {},
          child: Icon(Icons.notifications_none_outlined,
              size: Sizer.getTextSize(context, 0.08), color: Colors.white)),
      actions: [
        isDoctor? Container(
            margin: EdgeInsets.only(right: 6.sp),
            child: Icon(Icons.filter_alt,
                size: Sizer.getTextSize(context, 0.08), color: Colors.white)):
        Container(),
        InkWell(
            onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)))
      ],
      centerTitle: true,
      title: Container(
        width: Sizer.getWidth(context)/1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Coloring.third),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: Sizer.getHeight(context) / 15,
                child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(21)],
                    textDirection: TextDirection.rtl,
                    cursorColor: Coloring.primary,
                    style: TextStyle(
                        fontSize: Sizer.getTextSize(context, 0.05),
                        fontWeight: FontWeight.bold,
                        fontFamily: Font.fontfamily,
                        color: Coloring.primary2),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.white, width: 4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.white, width: 4)),
                        errorMaxLines: 15,
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.red, width: 4)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.red, width: 4)),
                        isDense: true,
                        hintText: hint,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                          fontSize: Sizer.getTextSize(context, 0.038),
                        ))),
              ),
            ),
            Expanded(
                child: Icon(Icons.search_rounded,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white))
          ],
        ),
      ),
      elevation: 0,
    );
  }

  static showRatingBar(BuildContext context) {
    return AlertDialog(
      backgroundColor: Coloring.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      title: Center(
        child: Text(":قيّم طبيبك  " , style: TextStyle(fontFamily: Font.fontfamily, fontSize:
        Sizer.getTextSize(context, 0.05), color: Colors.white)),
      ),
      content: Container(
        height: Sizer.getHeight(context)/6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full:  Icon(Icons.star, color: Colors.orange),
                    half:  Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ),
                    empty:  Icon(
                      Icons.star_outline,
                      color: Colors.white,
                    )),
                onRatingUpdate: (value) {
                }),
            InkWell(
              onTap: () {
               Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: Sizer.getWidth(context)/2.5,
                height: Sizer.getHeight(context)/15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Text("إضافة التقييم",style: TextStyle(fontFamily: Font.fontfamily, fontSize:
                Sizer.getTextSize(context, 0.05), color: Coloring.primary)),
              ),
            )
          ],
        ),
      ),
    );

  }
}
