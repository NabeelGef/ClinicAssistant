
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/router.dart';
import 'package:clinicassistant/Screen/clinicsPage/all_clinics_page.dart';
import 'package:clinicassistant/Screen/doctorsPage/all_doctors_page.dart';
import 'package:clinicassistant/Screen/homePage/home.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom0.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom4.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome1.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome2.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome3.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';


import 'Constant/color.dart';

void main() {
  RouterNav.setupRouter();
  runApp(DevicePreview(
      enabled: true,
      builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Coloring.primary,
    ));
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
      ScreenUtil.init(context , minTextAdapt: true , splitScreenMode: true );
      ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(1024, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      );
      return DevicePreview.appBuilder(context, child);
    },
      debugShowCheckedModeBanner: false,
      title: 'مساعد العيادات',
      theme: ThemeData(
        primaryColor: Coloring.primary,
        fontFamily: Font.fontfamily,
      ),
      home: Welcome0(),

    //initialRoute: "/",
    // routes: {
    //   '/' : (context) => Welcome1(),
    //   '/welcome2' : (context)=>Welcome2(),
    //   '/welcome3' : (context)=>Welcome3(),
    //   '/welcome4' : (context)=>Welcome4(),
    //   '/home' : (context) => Home(),
    //   '/home/allclinics':(context) => AllClinics(),
    //   '/home/alldoctors' : (context) => AllDoctors(),
    //},
              );
  }
}

