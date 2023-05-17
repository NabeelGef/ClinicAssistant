import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../homePage/home.dart';

class Welcome4 extends StatelessWidget {
  const Welcome4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);  // to re-show bars
    return Scaffold(
      body: Body(context)
    );
  }

  Body(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(
                  Font.urlImage+"background2.jpg"
              ),fit: BoxFit.fill)
          ),
        ),
        Column(
          children: [
            Expanded(
                flex: 4,
                child: Image.asset(Font.urlImage+"mainwelcome.png",width: Sizer.getWidth(context),fit: BoxFit.fill,
                  )) ,
            SizedBox(height: 57,),
            Expanded(
                child: Text(Font.header4 ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: Font.fontfamily ,
                        fontWeight: FontWeight.bold ,
                        color: Coloring.secondary,
                        fontSize: Sizer.getTextSize(context, 0.05)))),

            InkWell(
              onTap: () => RouterNav.fluroRouter.navigateTo(context, RouteName.Home),
              child: Container(

                alignment: Alignment.center,
                width: Sizer.getWidth(context)/2,
                height: Sizer.getHeight(context)/9,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(61.sp),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Coloring.primary,
                        Coloring.primary2
                      ],

                    )           ),
                child: Text("الدخول إلى\n الصفحة الرّئيسيّة" ,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: Font.fontfamily , fontSize:
                Sizer.getTextSize(context, 0.04) , color: Colors.white),),
              ),
            ),
            SizedBox(height: 75,)

          ],
        )
      ],
    );
  }
}
