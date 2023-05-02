import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Welcome1 extends StatelessWidget {
  const Welcome1({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
   //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);  // to re-show bars
     return Scaffold(
       floatingActionButton: Code.getFloatingPoint(context,'/welcome2'),
        body: Container(
          color: Coloring.primary,
          child:
          Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Image(
                      fit: BoxFit.cover,
                      image:AssetImage("assets/images/logoword.png"))),
              Expanded(child: Center(child:
              Text("مساعد العيادات",
                style: TextStyle(color: Coloring.customgrey ,
                    fontSize:
                    Sizer.getTextSize(context, 0.09)  ,
                    fontFamily: Font.fontfamily),))),
              Expanded(
                flex: 2,
                child: Center(child: AutoSizeText("التطبيق الأول في سورية لإدارة حجوزات المرضى في العيادات",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Coloring.customgrey ,fontWeight: FontWeight.bold,
                      fontSize: Sizer.getTextSize(context, 0.06)
                      , fontFamily: Font.fontfamily),)),
              )

            ],
          ),
        ),
   );
  }
}
