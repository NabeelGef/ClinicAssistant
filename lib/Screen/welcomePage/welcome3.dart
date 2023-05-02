import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Welcome3 extends StatelessWidget {
  const Welcome3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);  // to re-show bars

    return Scaffold(
      backgroundColor: Coloring.primary,
      floatingActionButton: Code.getFloatingPoint(context, '/welcome4'),
      body: Body(context)
    );
  }

  Body(BuildContext context) {
   return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image:AssetImage("assets/images/3doctorswelcome.png")),
        Center(child: Text("إمكانية الحجز بسهولة عند أي طبيب تختاره ",textAlign: TextAlign.center ,
          style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,
              fontSize: Sizer.getTextSize(context, 0.08) , fontFamily: Font.fontfamily),)),
      ],
    );
  }
}
