import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Screen/personal_profile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/personal_profile/bloc/event.dart';
import 'package:clinicassistant/Screen/personal_profile/bloc/states.dart';
import 'package:clinicassistant/blocShared/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../Constant/Route/routename.dart';
import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';
import '../../blocShared/sharedBloc.dart';
import '../../blocShared/state.dart';
import '../../widgets/Connectivity/bloc.dart';
import '../../widgets/Connectivity/state.dart';

// ignore: must_be_immutable
class PersonalProfile extends StatefulWidget {
  String token;
  PersonalProfile({Key? key, required this.token}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool isLoading = false;
  PersonalProfileBloc personalProfileBloc = PersonalProfileBloc(
      PersonalProfileStates(
          getAccount: GetAccount(personalInformation: null, error: ''),
          getNewImage: GetNewImage(image: null)));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connect) {
        if (connect is ConnectivityInitial) {
          // في حالة بيتأكد من وجود الانترنت
          return Center(
              child: CircularProgressIndicator(color: Coloring.primary));
        } else if (connect is NotConnectedState) {
          // في حالة  الانترنت غير موجود
          isLoading = false;
          if (state.getLoginState == null) {
            // عدم اتصال الانترنت مع عدم تسجيل الدخول
            return Scaffold(
                backgroundColor: Coloring.loginWhite,
                key: _scaffoldkey,
                appBar: MyAppBar(null),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: Code.ConnectionWidget(context, false));
          }
          return Scaffold(
              // عد الاتصال مع عدم تسجيل الدخول أو معه
              backgroundColor: Coloring.loginWhite,
              key: _scaffoldkey,
              appBar: MyAppBar(state.getTokenState!.token),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false));
        } else {
          // الاتصال ناجح وموجود
          if (!isLoading) {
            // الاتصال ناجح مع وجود تسجيل الدخول
            isLoading = true;
            personalProfileBloc
                .add(LoadingPersonalProfile(token: widget.token));
          }
          if (state.getLoginState == null) {
            //الاتصال ناجح مع عدم وجود تسجيل دخول
            return Scaffold(
                backgroundColor: Coloring.loginWhite,
                key: _scaffoldkey,
                appBar: MyAppBar(null),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: bodyInformation(context, state));
          }
          return Scaffold(
              // الاتصال ناجح مع عدم وجود تسجيل دخول
              backgroundColor: Coloring.loginWhite,
              key: _scaffoldkey,
              appBar: MyAppBar(state.getTokenState!.token),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: bodyInformation(context, state));
        }
      });
    });
  }

  Widget bodyInformation(BuildContext context, SharedState sharedState) {
    return Container(
        child: BlocBuilder<PersonalProfileBloc, PersonalProfileStates>(
            bloc: personalProfileBloc,
            builder: (context, state) {
              if (state.getAccount.personalInformation == null) {
                if (state.getAccount.error!.isNotEmpty) {
                  return Center(
                      child: Container(
                          child: Lottie.asset(
                              "${Font.urlLottie}notFoundAppointment.json")));
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.orange));
                }
              }
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CircleAvatar(
                            backgroundColor: Coloring.third,
                            radius: Sizer.getWidth(context) / 7,
                            backgroundImage: state.getNewImage.image != null
                                ? FileImage(state.getNewImage.image!)
                                    as ImageProvider
                                : state.getAccount.personalInformation!.patient!
                                            .profilePicture !=
                                        null
                                    ? NetworkImage(API.BaseUrlBack +
                                        state.getAccount.personalInformation!
                                            .patient!.profilePicture!)
                                    : null,
                            child: state.getAccount.personalInformation?.patient
                                            ?.profilePicture ==
                                        null &&
                                    state.getNewImage.image == null
                                ? Image.asset(
                                    "${Font.urlImage}doctoravatar.png")
                                : null,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  context: context,
                                  builder: (context) {
                                    return Code.makeSheet(context,
                                        personalProfileBloc, widget.token);
                                  });
                            },
                            child: Container(
                              height: Sizer.getHeight(context) / 30,
                              decoration: BoxDecoration(
                                  color: Coloring.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset("${Font.urlImage}camera.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "${state.getAccount.personalInformation!.patient!.firstname} ${state.getAccount.personalInformation!.patient!.lastname}",
                    style: TextStyle(
                        color: Coloring.primary,
                        fontSize: 15.r,
                        fontFamily: Font.fontfamily,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(color:Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          " الاسم الشّخصي :  ${state.getAccount.personalInformation!.patient!.firstname} ${state.getAccount.personalInformation!.patient!.lastname}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.r,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.person,
                        color: Coloring.primary,
                        size: 25.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      ),
                    ],
                  ),
                  Divider(color:Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          " تاريخ الميلاد : ${state.getAccount.personalInformation!.patient!.birthDate}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.r,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.calendar_month_sharp,
                        color: Coloring.primary,
                        size: 25.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      ),
                    ],
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          " رقم الموبايل :   ${state.getAccount.personalInformation!.patient!.phoneNumber} ",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.r,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.phone_android_rounded,
                        color: Coloring.primary,
                        size: 25.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      )
                    ],
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          "الجنس :${state.getAccount.personalInformation!.patient!.gender}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.r,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.man,
                        color: Coloring.primary,
                        size: 25.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      ),
                    ],
                  ),
                  Divider(color:Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          "عدد تحذيراتك : ${state.getAccount.personalInformation!.patient!.numberOfMissAppointment} ",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.r,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.dangerous,
                        color: Coloring.primary,
                        size: 25.r,
                      ),
                      SizedBox(
                        width: 10.r,
                      ),
                    ],
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              RouterNav.fluroRouter.navigateTo(context,
                                  RouteName.MyBook + "/${widget.token}",
                                  routeSettings: RouteSettings(
                                      arguments: {'token': widget.token}));
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 15.r),
                                height: Sizer.getHeight(context) / 10,
                                width: Sizer.getWidth(context) / 5,
                                decoration: BoxDecoration(
                                    color: Coloring.primary,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(Icons.calendar_month,
                                    color: Colors.white, size: 35.r)),
                          ),
                          Text("حجوزاتي",
                              style: TextStyle(
                                  color:Coloring.primary,
                                  fontSize: 15.r,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
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
                                        child: Lottie.asset(
                                            "${Font.urlLottie}logout.json"),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<SharedBloc>()
                                                .add(SignoutLogin());
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
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
                                                borderRadius:
                                                    BorderRadius.circular(25),
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
                            child: Container(
                                margin: EdgeInsets.only(top: 15.r),
                                height: Sizer.getHeight(context) / 10,
                                width: Sizer.getWidth(context) / 5,
                                decoration: BoxDecoration(
                                    color: Coloring.primary,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(Icons.logout,
                                    color: Colors.white, size: 35.r)),
                          ),
                          Text("تسجيل الخروج",
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontSize: 15.r,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )
                ],
              );
            }));
  }

  MyAppBar(String? token) {
    return Code.AppBarProfile(_scaffoldkey, context, token);
  }
}
