import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/router.dart';
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
       //floatingActionButton: Code.getFloatingPoint(context,'/welcome2'),
        body: MyBody(context)
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
                flex: 2,
                child: Image.asset(Font.urlImage+"doctorswelcome.jpg",fit: BoxFit.fill,)) ,
            SizedBox(height: 50,),
            Expanded(
                child: Text(Font.header1 ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: Font.fontfamily ,
                        fontWeight: FontWeight.bold ,
                        color: Coloring.secondary,
                        fontSize: Sizer.getTextSize(context, 0.08)))),
            InkWell(
              onTap: () => RouterNav.fluroRouter.navigateTo(context, "/welcome2"),
              child: Container(
                alignment: Alignment.center,
                width: Sizer.getWidth(context)/2,
                height: Sizer.getHeight(context)/15,

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
                child: Text("استمرار" , style: TextStyle(fontFamily: Font.fontfamily , fontSize:
                Sizer.getTextSize(context, 0.06) , color: Colors.white),),
              ),
            ),
            SizedBox(height: 75,)

          ],
        )
      ],
    );
  }
}
