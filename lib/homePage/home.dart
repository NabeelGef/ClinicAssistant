import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/clinicsPage/all_clinics_page.dart';
import 'package:clinicassistant/doctorsPage/all_doctors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(context),
      drawer: Code.DrawerNative(context),
      body: Body(context)
    );
  }
  //Make Body
  Body(BuildContext context){
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Image.asset("assets/images/medicine.png" , fit: BoxFit.contain),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context,'/home/allclinics');
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: Sizer.getHeight(context)/6,
                width: Sizer.getWidth(context)/4,
                child: Card(
                  elevation:5,
                  child: Column(
                    children: [
                      Expanded(child: Image.asset("assets/images/healthclinic.png")),
                      Text("العيادات",style: TextStyle(color: Colors.black ,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context,'/home/alldoctors');
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: Sizer.getHeight(context)/6,
                width: Sizer.getWidth(context)/4,
                child: Card(
                  elevation:5,
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.asset("assets/images/doctor.png")),
                      Text("الأطباء",style: TextStyle(color: Colors.black ,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(child: SizedBox())
      ],
    );
  }

  //Make AppBar
  MyAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Coloring.custompurble
      ),
      toolbarHeight: Sizer.getHeight(context)/3.5,
      elevation: 0,
      centerTitle: true,
      title: Image.asset("assets/images/logoword.png"),
      backgroundColor: Colors.white,
      leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(Icons.menu ,size: Sizer.getTextSize(context, 0.1), color: Coloring.primary)),
      actions: [
        Icon(Icons.notifications_none ,size: Sizer.getTextSize(context, 0.1), color: Coloring.primary)
      ],
    );
  }
}
