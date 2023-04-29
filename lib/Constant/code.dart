import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/doctorsPage/bloc/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Code{

//Make a const Drawer in Doctor and clinic page

 static  Widget  DrawerNative(BuildContext context){
    return Drawer(
      width: Sizer.getWidth(context)/1.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView(
          children: [
            Container(
              height: Sizer.getHeight(context)/5,
              child: DrawerHeader(
                curve: Curves.easeIn,

                decoration: BoxDecoration(

                    color: Coloring.custompurble
                ),
                child:Row(
                  children: [
                    SizedBox(width: 5),
                    Container(
                        alignment: Alignment.center,
                        width: Sizer.getWidth(context)/5,
                        height: Sizer.getWidth(context)/5  ,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              repeat: ImageRepeat.noRepeat,
                              image: AssetImage("assets/images/logo.png")),
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.grey[100],
                        ),
                        /*child:Center(
                          child: Image(fit: BoxFit.fill
                               image:AssetImage("assets/images/logo.png"
                              )),
                        )*/
                    ),
                    SizedBox(width: 10),
                    Text("مساعد العيادات",style: TextStyle(color: Colors.black ,
                        fontFamily: Font.fontfamily ,
                        fontSize: Sizer.getTextSize(context, 0.05),
                        fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            SizedBox(height: Sizer.getHeight(context)/20),
            InkWell(
              onTap: () {
                //Go To Home
              },
              child: Row(
                children: [
                  SizedBox(width: 20),

                  Icon(Icons.home , color: Coloring.primary, size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20,),
                  Text("الصّفحة الرّئيسيّة", style: TextStyle(color: Colors.black ,
                      fontFamily: Font.fontfamily ,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Divider(color: Colors.black , thickness: 2),
            SizedBox(height: Sizer.getHeight(context)/25),
            InkWell(
              onTap: () {
                // Go To Loginpage
              },
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.login , color: Coloring.primary, size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20,),
                  Text("تسجيل الدّخول", style: TextStyle(color: Colors.black ,
                      fontFamily: Font.fontfamily ,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Divider(color: Colors.black , thickness: 2,),
            SizedBox(height: Sizer.getHeight(context)/25),
            InkWell(
              onTap: () {
                //Go To AboutPage
              },
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.info_outline_rounded , color: Coloring.primary, size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("حول النّظام", style: TextStyle(color: Colors.black ,
                      fontFamily: Font.fontfamily ,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Divider(color: Colors.black , thickness: 2),
            SizedBox(height: Sizer.getHeight(context)/25),
            InkWell(
              onTap: () {
                // Go To Settings
              },
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.settings , color: Coloring.primary, size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("الإعدادات",
                      style: TextStyle(color: Colors.black ,
                      fontFamily: Font.fontfamily ,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Divider(color: Colors.black , thickness: 2),
            SizedBox(height: Sizer.getHeight(context)/25),
            InkWell(
              onTap: () {
                // Go To Privacy
              },
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.privacy_tip_outlined , color: Coloring.primary, size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("الخصوصية\n  وسياسة الاستخدام",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black ,
                      fontFamily: Font.fontfamily ,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Divider(color: Colors.black , thickness: 2),
          ]),
    );
  }
 //Make a const FloatingPoint in Doctor and clinic page

 static getFloatingPoint(BuildContext context ,  String path){
   return Container(
     width: Sizer.getWidth(context)/8,
     height: Sizer.getWidth(context)/8,
     child: FloatingActionButton(
       onPressed: () {
         Navigator.pushReplacementNamed(context, path);
       },
       backgroundColor: Coloring.custompurble,
       child: Icon(Icons.navigate_next , color: Colors.grey , size: 50,),
     ),
   );
 }

 //Make a conts AppBar in Doctor and clinic page
 static Widget AppBarDoctorsAndClinics(GlobalKey<ScaffoldState> _scaffoldkey
     ,  BuildContext context ,
     bool isSearchSelected ,
     bool isDoctor ,
     String title ,
     String hint) {
   return AppBar(
     toolbarHeight: Sizer.getHeight(context)/8,
     backgroundColor:  Colors.white,
     systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white
     ),
     leading: InkWell(
         onTap: () {
           _scaffoldkey.currentState!.openDrawer();
         },
         child: Icon(Icons.menu ,size: Sizer.getTextSize(context, 0.08), color: Coloring.primary)),
     actions: [
       InkWell(onTap: () {
         if(isDoctor) {
           AllDoctorsBloc.get(context)
               .add(SearchEventDoctor());
         }else{
           AllClinicsBloc.get(context).add(SearchEventClinic());
         }
       },
           child:isSearchSelected ? Container(
               margin: EdgeInsets.only(right: 10),
               child: Icon(Icons.cancel_outlined,
                   size: Sizer.getTextSize(context, 0.08),
                   color: Coloring.primary))
               :Icon(Icons.search ,size: Sizer.getTextSize(context, 0.08), color: Coloring.primary)
       ),
       !isSearchSelected?Icon(Icons.notifications_none ,size: Sizer.getTextSize(context, 0.08), color: Coloring.primary)
           :Container()
     ],
     centerTitle: true,
     titleSpacing: Sizer.getWidth(context)/100,
     title: !isSearchSelected? Center(
       child: Text(title,style: TextStyle(
           fontSize: Sizer.getTextSize(context, 0.06),
           fontWeight: FontWeight.bold , fontFamily: Font.fontfamily , color: Coloring.customgrey)),
     )
         :Container(
       width: Sizer.getWidth(context),
       height: Sizer.getHeight(context)/14,
             child: TextField(
           inputFormatters: [
             LengthLimitingTextInputFormatter(21)
           ],
           textDirection: TextDirection.rtl,
           cursorColor: Coloring.primary,
           style: TextStyle(fontSize: Sizer.getTextSize(context, 0.05) ,
               fontWeight: FontWeight.bold,
               fontFamily: Font.fontfamily ,
               color: Coloring.customgrey),
           decoration: InputDecoration(
               enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                   borderSide: BorderSide(color: Coloring.primary , width: 4)
               ),
               focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                   borderSide: BorderSide(color: Coloring.primary , width: 4)
               ),
               errorMaxLines: 15,
               focusedErrorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                   borderSide: BorderSide(color: Colors.red , width: 4)
               ),
               errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                   borderSide: BorderSide(color: Colors.red , width: 4)
               ),
               isDense: true,
               prefixIcon: Container(
                 margin: EdgeInsets.only(left: 10.0),
                 padding: EdgeInsets.only(right: 10.0),
                 child: Icon(Icons.search ,size: Sizer.getTextSize(context, 0.09), color: Coloring.primary),
               ),
               hintText: hint,
               contentPadding: EdgeInsets.only( right: Sizer.getWidth(context)/15 , bottom: 20 ),
               hintTextDirection: TextDirection.rtl,
               hintStyle: TextStyle(
                 color: Coloring.customgrey,
                 fontSize: Sizer.getTextSize(context, 0.05),
                 fontWeight: FontWeight.bold,
                 fontStyle: FontStyle.italic,
               )
           )
       ),
     ),
     elevation: 1,
   );
 }

}
