import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/router.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome0 extends StatefulWidget {
  const Welcome0({Key? key}) : super(key: key);

  @override
  State<Welcome0> createState() => _Welcome0State();
}

class _Welcome0State extends State<Welcome0> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Coloring.primary
    // ));
    return Scaffold(
      body: MyBody(context),
    );
  }

  MyBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
               Font.urlImage+"background.png"
            ),fit: BoxFit.fill)
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(Font.urlImage+"logo.png",
                  width: Sizer.getWidth(context)/1.5,
                height:Sizer.getHeight(context)/1.5,
                ),
              ),
            ) ,
            InkWell(
              onTap: () => RouterNav.fluroRouter.navigateTo(context, "/welcome1"),
              child: Container(
                alignment: Alignment.center,
                width: Sizer.getWidth(context)/2,
                height: Sizer.getHeight(context)/12,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(61.sp),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: [
                    Coloring.primary,
                    Coloring.primary2
                  ],

                  )
                ),
                child: Text("استمرار" , style: TextStyle(fontFamily: Font.fontfamily , fontSize:
                Sizer.getTextSize(context, 0.06) , color: Colors.white),),

              ),

            ),
            SizedBox(height: 75)
          ],
        )
      ],
    );
  }
}
