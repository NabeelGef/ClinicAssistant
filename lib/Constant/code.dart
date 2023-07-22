import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/event.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/blocNotification/bloc.dart';
import 'package:clinicassistant/blocNotification/state.dart';
import 'package:clinicassistant/blocShared/event.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/main.dart';
import 'package:clinicassistant/repository/evaluate_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../Screen/clinicsPage/bloc/events.dart';
import 'package:badges/badges.dart' as badges;
import 'Route/routename.dart';
import 'Route/router.dart';

class Code {
//Make a const Drawer in Doctor and clinic page

  static Widget DrawerNative(
      BuildContext context, GlobalKey<ScaffoldState> key) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        //color: Colors.red,
        height: Sizer.getHeight(context) / 1.7,
        width: Sizer.getWidth(context),
        child: Drawer(
          backgroundColor: Coloring.primary3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(children: [
            /*Container(
                  height: Sizer.getHeight(context)/5,
                  child: DrawerHeader(
                    curve: Curves.easeIn,

                    decoration: BoxDecoration(

                        color: Coloring.primary
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
                            */ /*child:Center(
                              child: Image(fit: BoxFit.fill
                                   image:AssetImage("assets/images/logo.png"
                                  )),
                            )*/ /*
                        ),
                        SizedBox(width: 10),
                        Text("مساعد العيادات",style: TextStyle(color: Colors.black ,
                            fontFamily: Font.fontfamily ,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),*/

            SizedBox(height: Sizer.getHeight(context) / 20),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  //Close EndDrawer
                  key.currentState!.closeEndDrawer();
                },
                child: Icon(Icons.close,
                    size: Sizer.getTextSize(context, 0.09),
                    color: Colors.white),
              ),
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(context, RouteName.Home);
                //Go To Home
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.home,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("الصّفحة الرّئيسيّة",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(context, RouteName.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.key,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("تسجيل الدّخول",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                //Go To AboutPage
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("حول النّظام",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Settings
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.settings,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("الإعدادات",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Privacy
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.privacy_tip_outlined,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 10),
                  Text("الخصوصية  وسياسة الاستخدام",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //Make Second drawer native for login one
  static Widget DrawerNativeSeconde(
      BuildContext context, GlobalKey<ScaffoldState> key, String token) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        //color: Colors.red,
        height: Sizer.getHeight(context) / 1.7,
        width: Sizer.getWidth(context),
        child: Drawer(
          backgroundColor: Coloring.primary3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(children: [
            /*Container(
                  height: Sizer.getHeight(context)/5,
                  child: DrawerHeader(
                    curve: Curves.easeIn,

                    decoration: BoxDecoration(

                        color: Coloring.primary
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
                            */ /*child:Center(
                              child: Image(fit: BoxFit.fill
                                   image:AssetImage("assets/images/logo.png"
                                  )),
                            )*/ /*
                        ),
                        SizedBox(width: 10),
                        Text("مساعد العيادات",style: TextStyle(color: Colors.black ,
                            fontFamily: Font.fontfamily ,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),*/

            SizedBox(height: Sizer.getHeight(context) / 20),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  //Close EndDrawer
                  key.currentState!.closeEndDrawer();
                },
                child: Icon(Icons.close,
                    size: Sizer.getTextSize(context, 0.09),
                    color: Colors.white),
              ),
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                //Go To Home
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.home,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  Text("الصّفحة الرّئيسيّة",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Loginpage
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.person,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      //RouterNav.fluroRouter.navigateTo(context, RouteName.login);
                    },
                    child: Text("الملف الشخصي",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Font.fontfamily,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                //Go To AboutPage
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("حول النّظام",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                // Go To Settings
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.settings,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("الإعدادات",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(
                    context, RouteName.MyBook + "/${token}",
                    routeSettings: RouteSettings(arguments: {'token': token}));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 20),
                  Text("حجوزاتي",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: Sizer.getHeight(context) / 50),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Coloring.third,
                        title: Text(
                          "هل تريد تأكيد تسجيل الخروج؟؟",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                        content: Container(
                          width: Sizer.getWidth(context) / 2,
                          height: Sizer.getHeight(context) / 5,
                          child: Lottie.asset("${Font.urlLottie}logout.json"),
                        ),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          InkWell(
                            onTap: () {
                              context.read<SharedBloc>().add(SignoutLogin());
                              Navigator.pop(context);
                              Navigator.pop(context);
                              RouterNav.fluroRouter.navigateTo(
                                  context, RouteName.Home,
                                  clearStack: true);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Sizer.getWidth(context) / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Coloring.loginWhite),
                              child: Text("نعم",
                                  style: TextStyle(
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Sizer.getWidth(context) / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Coloring.loginWhite),
                              child: Text("لا",
                                  style: TextStyle(
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp)),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.logout,
                      color: Colors.white,
                      size: Sizer.getTextSize(context, 0.08)),
                  SizedBox(width: 10),
                  Text("تسجيل خروج",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font.fontfamily,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //Make a const FloatingPoint in Doctor and clinic page

  //Make a conts AppBar in Doctor and clinic page
  static Widget AppBarHome(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context, String? token) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            color: Coloring.primary,
          ),
          width: Sizer.getWidth(context),
          height: Sizer.getHeight(context) / 15,
        ),
        AppBar(
          toolbarHeight: Sizer.getHeight(context) / 3,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(
                    context, RouteName.Notification + "/${token}",
                    routeSettings: RouteSettings());
              },
              child: Container(
                margin: EdgeInsets.only(top: 25.sp, left: 10.sp),
                child: badges.Badge(
                  badgeAnimation: badges.BadgeAnimation.scale(),
                  position: badges.BadgePosition.topEnd(),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Coloring.primary,
                  ),
                  badgeContent: BlocBuilder<NotificationSocketBloc,
                          NotificationSocketState>(
                      bloc: notificationSocketBloc,
                      builder: (context, state) {
                        return Text(
                          "${state.getNumberOfUnReadState.num}",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        );
                      }),
                  child: Icon(Icons.notifications_none_outlined,
                      size: Sizer.getTextSize(context, 0.1),
                      color: Coloring.primary),
                ),
              )),
          actions: [
            InkWell(
                onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
                child: Container(
                    margin: EdgeInsets.only(right: 6.sp),
                    child: Icon(Icons.menu,
                        size: Sizer.getTextSize(context, 0.1),
                        color: Coloring.primary)))
          ],
        ),
      ],
    );
  }

  static Widget AppBarProfile(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context, String? token) {
    return AppBar(
      toolbarHeight: Sizer.getHeight(context) / 6,
      backgroundColor: Coloring.primary,
      leading: InkWell(
          onTap: () {
            RouterNav.fluroRouter.navigateTo(
                context, RouteName.Notification + "/${token}",
                routeSettings: RouteSettings());
          },
          child: Container(
            margin: EdgeInsets.only(top: 40.sp, left: 10.sp),
            child: badges.Badge(
              badgeAnimation: badges.BadgeAnimation.scale(),
              position: badges.BadgePosition.topEnd(),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.white,
              ),
              badgeContent:
                  BlocBuilder<NotificationSocketBloc, NotificationSocketState>(
                      bloc: notificationSocketBloc,
                      builder: (context, state) {
                        return Text(
                          "${state.getNumberOfUnReadState.num}",
                          style: TextStyle(
                              color: Coloring.primary, fontSize: 20.sp),
                        );
                      }),
              child: Icon(Icons.notifications_none_outlined,
                  size: Sizer.getTextSize(context, 0.1), color: Colors.white),
            ),
          )),
      actions: [
        InkWell(
            onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)))
      ],
      centerTitle: true,
      title: Image.asset(
        "${Font.urlImage}logo.png",
        width: Sizer.getWidth(context) / 5,
        height: Sizer.getHeight(context) / 5,
      ),
    );
  }

  static Widget AppBarWithMyNotification(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context, String text, bool isTab) {
    return AppBar(
        toolbarHeight: isTab == true
            ? Sizer.getHeight(context) / 5
            : Sizer.getHeight(context) / 6,
        backgroundColor: Coloring.primary,
        bottom: isTab == true
            ? TabBar(
                labelStyle: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontSize: Sizer.getWidth(context) / 15),
                unselectedLabelColor: Colors.white,
                labelColor: Coloring.yellow,
                indicatorColor: Colors.white,
                tabs: [
                    Tab(
                      text: 'التذكيرات',
                    ),
                    Tab(
                      text: 'التأخيرات و الإلغاءات ',
                    )
                  ])
            : null,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 18.sp, color: Colors.white)),
        actions: [
          InkWell(
              onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
              child: Container(
                  margin: EdgeInsets.only(right: 6.sp),
                  child: Icon(Icons.menu,
                      size: Sizer.getTextSize(context, 0.08),
                      color: Colors.white)))
        ],
        centerTitle: true,
        title: Text("$text",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: Font.fontfamily,
                fontSize: 25.sp,
                color: Colors.white)));
  }

  static Widget AppBarWithMyBook(GlobalKey<ScaffoldState> _scaffoldkey,
      BuildContext context, String text, bool isTab, String? token) {
    return AppBar(
        toolbarHeight: isTab == true
            ? Sizer.getHeight(context) / 5
            : Sizer.getHeight(context) / 6,
        backgroundColor: Coloring.primary,
        bottom: isTab == true
            ? TabBar(
                labelStyle: TextStyle(
                    fontFamily: Font.fontfamily,
                    fontSize: Sizer.getWidth(context) / 15),
                unselectedLabelColor: Colors.white,
                labelColor: Coloring.yellow,
                indicatorColor: Colors.white,
                tabs: [
                    Tab(
                      text: 'السّارية',
                    ),
                    Tab(
                      text: 'السّابقة',
                    )
                  ])
            : null,
        leading: InkWell(
            onTap: () {
              RouterNav.fluroRouter.navigateTo(
                  context, RouteName.MyBook + "/${token}",
                  routeSettings: RouteSettings(arguments: {'token': token}));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.sp, left: 10.sp),
              child: badges.Badge(
                badgeAnimation: badges.BadgeAnimation.scale(),
                position: badges.BadgePosition.topEnd(),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.white,
                ),
                badgeContent: BlocBuilder<NotificationSocketBloc,
                        NotificationSocketState>(
                    bloc: notificationSocketBloc,
                    builder: (context, state) {
                      return Text(
                        "${state.getNumberOfUnReadState.num}",
                        style:
                            TextStyle(color: Coloring.primary, fontSize: 20.sp),
                      );
                    }),
                child: Icon(Icons.notifications_none_outlined,
                    size: Sizer.getTextSize(context, 0.1), color: Colors.white),
              ),
            )),
        actions: [
          InkWell(
              onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
              child: Container(
                  margin: EdgeInsets.only(right: 6.sp),
                  child: Icon(Icons.menu,
                      size: Sizer.getTextSize(context, 0.08),
                      color: Colors.white)))
        ],
        centerTitle: true,
        title: Text("$text",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: Font.fontfamily,
                fontSize: 25.sp,
                color: Colors.white)));
  }

  static Widget ConnectionWidget(BuildContext context, bool isChanged) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("${Font.urlLottie}notConnection.json"),
          Text("يوجد مشكلة في اتّصالك",
              style: TextStyle(
                  color: isChanged ? Coloring.loginWhite : Coloring.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Font.fontfamily,
                  fontSize: Sizer.getTextSize(context, 0.06)))
        ],
      ),
    );
  }

  static Widget AppBarDoctorsAndClinics(
      GlobalKey<ScaffoldState> _scaffoldkey,
      GlobalKey<FormState> form,
      BuildContext context,
      TextEditingController textEditingController,
      bool isDoctor,
      String hint,
      AllDoctorsBloc allDoctorsBloc,
      AllClinicsBloc allClinicsBloc,
      String? token) {
    return AppBar(
      toolbarHeight: Sizer.getHeight(context) / 6,
      backgroundColor: Coloring.primary,
      leading: InkWell(
          onTap: () {
            RouterNav.fluroRouter.navigateTo(
                context, RouteName.MyBook + "/${token}",
                routeSettings: RouteSettings(arguments: {'token': token}));
          },
          child: Container(
            margin: EdgeInsets.only(top: 25.sp, left: 10.sp),
            child: badges.Badge(
              badgeAnimation: badges.BadgeAnimation.scale(),
              position: badges.BadgePosition.topEnd(),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Coloring.primary,
              ),
              badgeContent:
                  BlocBuilder<NotificationSocketBloc, NotificationSocketState>(
                      bloc: notificationSocketBloc,
                      builder: (context, state) {
                        return Text(
                          "${state.getNumberOfUnReadState.num}",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                        );
                      }),
              child: Icon(Icons.notifications_none_outlined,
                  size: Sizer.getTextSize(context, 0.1),
                  color: Coloring.primary),
            ),
          )),
      actions: [
        isDoctor
            ? Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.filter_alt,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white))
            : Container(),
        InkWell(
            onTap: () => _scaffoldkey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)))
      ],
      centerTitle: true,
      title: Row(
        children: [
          Expanded(
            flex: 6,
            child: Form(
              key: form,
              child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: textEditingController,
                  inputFormatters: [LengthLimitingTextInputFormatter(21)],
                  textDirection: TextDirection.rtl,
                  cursorColor: Coloring.primary,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يجب ملئ الحقل";
                    }
                    return null;
                  },
                  style: TextStyle(
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold,
                      fontFamily: Font.fontfamily,
                      color: Coloring.primary2),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (isDoctor) {
                              if (form.currentState!.validate()) {
                                allDoctorsBloc.add(LoadingDoctors(
                                    textEditingController.text, null, null));
                              }
                            } else {
                              if (form.currentState!.validate()) {
                                allClinicsBloc.add(SearchEventClinic(
                                    textEditingController.text));
                              }
                            }
                          },
                          child: Icon(Icons.search,
                              size: 25.sp, color: Colors.grey)),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      errorMaxLines: 1,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.red, width: 3)),
                      isDense: true,
                      hintText: hint,
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        fontSize: Sizer.getTextSize(context, 0.038),
                      ))),
            ),
          ),
          /*InkWell(
            onTap: () {
              if(isDoctor){
                if(form.currentState!.validate()) {
                  allDoctorsBloc.add(
                      LoadingDoctors(textEditingController.text,
                          null, null));
                }
              }else{
                //search on Clinic
              }
            },
            child: Expanded(
                child: Icon(Icons.search_rounded,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)),
          )*/
        ],
      ),
      elevation: 0,
    );
  }

  static showRatingBar(DoctorProfileDataBloc doctorProfileDataBloc,
      BuildContext context, String token, String doctorId, double init) {
    double initialRating = init;
    return AlertDialog(
      backgroundColor: Coloring.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(":قيّم طبيبك  ",
            style: TextStyle(
                fontFamily: Font.fontfamily,
                fontSize: Sizer.getTextSize(context, 0.05),
                color: Colors.white)),
      ),
      content: Container(
        height: Sizer.getHeight(context) / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RatingBar(
                initialRating: initialRating,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.orange),
                    half: Icon(
                      Icons.star_half,
                      color: Colors.orange,
                    ),
                    empty: Icon(
                      Icons.star_outline,
                      color: Colors.white,
                    )),
                onRatingUpdate: (value) {
                  initialRating = value;
                }),
            InkWell(
              onTap: () async {
                String? data =
                    await EvaluateRepo.evaluate(initialRating, token, doctorId);
                if (data != null && data.isNotEmpty) {
                  Fluttertoast.showToast(
                      msg: "$data",
                      fontSize: 20.sp,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.white,
                      textColor: Coloring.primary);
                  doctorProfileDataBloc
                      .add(GetEvaluate(token: token, doctorId: doctorId));
                }
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: Sizer.getWidth(context) / 2.5,
                height: Sizer.getHeight(context) / 15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Text("إضافة التقييم",
                    style: TextStyle(
                        fontFamily: Font.fontfamily,
                        fontSize: Sizer.getTextSize(context, 0.05),
                        color: Coloring.primary)),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
