import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/welcomePage/welcom4.dart';
import 'package:clinicassistant/welcomePage/welcome3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constant/color.dart';
import '../Constant/font.dart';

class Welcome2 extends StatelessWidget {
  const Welcome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);  // to re-show bars
    return Scaffold(
      backgroundColor: Coloring.primary,
      floatingActionButton: Code.getFloatingPoint(context, "/welcome3"),
      body: Body(context)
      /*Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Image(image:AssetImage("assets/images/alldoctorswelcome.png")),
          Center(child: Text("مجموعة من الأطباء الاختصاصين في مكان واحد فقط ",textAlign: TextAlign.center ,
            style: TextStyle(color: Colors.white , fontSize: 25 , fontFamily: Font.fontfamily),)),

        ],
      )*/

    );

    }
  Body(BuildContext context){
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/welcom2test.jpg"))
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 50),
          alignment: Alignment.bottomCenter,
          child: Text("مجموعة من الأطباء الاختصاصين في مكان واحد فقط ",textAlign: TextAlign.center ,
            style: TextStyle(color: Colors.purple , fontSize: Sizer.getTextSize(context, 0.07) , fontFamily: Font.fontfamily),),
        )
      ],
    );
  }
}
