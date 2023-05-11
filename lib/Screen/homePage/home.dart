import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/router.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Font.urlImage+'background.png' , fit: BoxFit.fill ,
          height: Sizer.getHeight(context) , width: Sizer.getWidth(context)),
        Scaffold(
          backgroundColor: Colors.transparent,
            key: _scaffoldKey,
          //appBar: MyAppBar(context),
          endDrawer: Code.DrawerNative(context , _scaffoldKey),
          body: Body(context)
        ),
      ],
    );
  }
  //Make Body
  Body(BuildContext context){
    return Stack(
      children: [
        ClipOval(
          child: Container(
            width: Sizer.getWidth(context),
            height: Sizer.getHeight(context)/20,
            color: Coloring.primary,
          ),
        ),
        Column(
          children: [
            SizedBox(height: Sizer.getHeight(context)/20,),
            MyAppBar(context),
            Expanded(child: Image.asset(Font.urlImage+'logo.png')) ,
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Coloring.primary
                      ),
                      child: Image.asset(Font.urlImage+'clinicIcon.png'),
                    ),
                    Text("العيادات",style: TextStyle(color: Coloring.secondary, fontFamily: Font.fontfamily ,
                        fontSize: Sizer.getTextSize(context, 0.07)),)
                  ],
                ),
                InkWell(
                  onTap: () {
                    RouterNav.fluroRouter.navigateTo(context, "/home/alldoctors");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Coloring.primary
                        ),
                        child: Image.asset(Font.urlImage+'doctorIcon.png'),
                      ),
                      Text("الأطبّاء",style: TextStyle(color: Coloring.secondary, fontFamily: Font.fontfamily ,
                          fontSize: Sizer.getTextSize(context, 0.07)),)
                    ],
                  ),
                )
              ],
            ))

          ],
        )
        ],
    );
  }

  //Make AppBar
  MyAppBar(BuildContext context) {
    return AppBar(
      //toolbarHeight: Sizer.getHeight(context)/3.5,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () {
          },
        child: Icon(Icons.notifications_none_outlined ,size: Sizer.getTextSize(context, 0.1), color: Coloring.primary)),
      actions: [
        InkWell(
            onTap: () =>    _scaffoldKey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu ,size: Sizer.getTextSize(context, 0.1), color: Coloring.primary)))
      ],
    );
  }
}
