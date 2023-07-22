import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constant/color.dart';
import '../Constant/font.dart';
import '../Constant/sizer.dart';

class AlertDialogIsNotLogin extends StatelessWidget {
  const AlertDialogIsNotLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Coloring.primary2,
      title: Center(
        child: Text("انت لست مسجّل دخولك",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontFamily: Font.fontfamily,
                fontWeight: FontWeight.bold)),
      ),
      content: InkWell(
        onTap: () => RouterNav.fluroRouter
            .navigateTo(context, RouteName.login, clearStack: true),
        child: Container(
          alignment: Alignment.center,
          width: Sizer.getWidth(context) / 2,
          height: Sizer.getHeight(context) / 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(61.sp),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Coloring.primary, Coloring.primary2],
              // )
              color: Coloring.third3),
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(
                fontFamily: Font.fontfamily,
                fontSize: 20.sp,
                color: Coloring.primary2),
          ),
        ),
      ),
    );
  }
}
