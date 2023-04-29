import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constant/font.dart';
import '../homePage/home.dart';

class Welcome4 extends StatelessWidget {
  const Welcome4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);  // to re-show bars
    return Scaffold(
      backgroundColor: Coloring.primary,
      body: Body(context)
    );
  }

  Body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 50),
        Expanded(flex: 3, child: Image(image:AssetImage("assets/images/bookingwelcome.png"))),
        Expanded(
          child: Center(child: Text("إمكانية تنظيم مواعيدك واختيار المواعيد المتاحة والتي تناسبك ",textAlign: TextAlign.center ,
            style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold, fontSize: Sizer.getTextSize(context, 0.06) , fontFamily: Font.fontfamily),)),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },

          child: Container(
            margin: EdgeInsets.only(top: 50),
            width: Sizer.getWidth(context)/1.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Text("الانتقال للصفحة الرّئيسيّة",style: TextStyle(
                color: Coloring.custompurble,
                fontFamily: Font.fontfamily,
                fontWeight: FontWeight.bold,
                fontSize: Sizer.getTextSize(context, 0.05),

              ),),
            ),
          ),
        ),
        Spacer()

      ],
    );
  }
}
