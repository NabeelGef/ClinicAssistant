import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/CanclePage/cancle.dart';
import 'package:clinicassistant/Screen/myBookPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/myBookPage/bloc/event.dart';
import 'package:clinicassistant/Screen/myBookPage/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class MyBook extends StatefulWidget {
  final token;
  const MyBook({super.key, required this.token});

  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool isLoading = false;
  MyBookBloc myBookBloc = MyBookBloc(MyBookState(
      previousMyBookState:
          PreviousMyBookState(error: "", currentAppointment: null),
      currentMyBookState:
          CurrentMyBookState(error: "", currentAppointment: null)));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connect) {
        if (connect is ConnectivityInitial) {
          return Center(
              child: CircularProgressIndicator(color: Coloring.primary));
        } else if (connect is NotConnectedState) {
          isLoading = false;
          if (state.getLoginState == null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                key: _scaffoldkey,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(120.sp),
                    child: Code.AppBarWithMyBook(
                        _scaffoldkey, context, 'حجوزاتي ', true, null)),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: Code.ConnectionWidget(context, false),
              ),
            );
          }
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldkey,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(120.sp),
                  child: Code.AppBarWithMyBook(_scaffoldkey, context, 'حجوزاتي',
                      true, state.getTokenState!.token)),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false),
            ),
          );
        } else {
          if (!isLoading) {
            isLoading = true;
            myBookBloc.add(LoadingMyCurrentAppointment(widget.token));
            myBookBloc.add(LoadingMyPreviousAppointment(widget.token));
          }
          if (state.getLoginState == null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Coloring.third2,
                key: _scaffoldkey,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(120.sp),
                    child: Code.AppBarWithMyBook(
                        _scaffoldkey, context, 'حجوزاتي ', true, null)),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: BodyMyBook(),
              ),
            );
          }
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Coloring.third2,
              key: _scaffoldkey,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(120.sp),
                  child: Code.AppBarWithMyBook(_scaffoldkey, context, 'حجوزاتي',
                      true, state.getTokenState!.token)),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: BodyMyBook(),
            ),
          );
        }
      });
    });
  }

  BodyMyBook() {
    return TabBarView(
      children: [futureBook(), previousBook()],
    );
  }

  futureBook() {
    return BlocBuilder<MyBookBloc, MyBookState>(
        bloc: myBookBloc,
        builder: (context, state) {
          if (state.currentMyBookState.currentAppointment == null) {
            if (state.currentMyBookState.error.isNotEmpty) {
              if (state.currentMyBookState.error == "Not Found") {
                return Center(
                    child: Lottie.asset("${Font.urlLottie}notFound.json"));
              }
              return Center(child: Text("${state.currentMyBookState.error}"));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Coloring.third3,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: state
                                          .currentMyBookState
                                          .currentAppointment!
                                          .appointments![index]
                                          .workTime!
                                          .doctor!
                                          .profilePicture ==
                                      null
                                  ? Image.asset(
                                      "${Font.urlImage}doctoravatar.png")
                                  : Image.network(state
                                      .currentMyBookState
                                      .currentAppointment!
                                      .appointments![index]
                                      .workTime!
                                      .doctor!
                                      .profilePicture!),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                      "الطبيب ${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.firstname} ${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.lastname}",
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontSize: 20.sp,
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "اختصاص : ${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.specialty!.specialtyName}",
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontSize:
                                              Sizer.getWidth(context) / 25,
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                RouterNav.fluroRouter.navigateTo(
                                  context,
                                  RouteName.Booking +
                                      "/${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.doctorId}/${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.clinicId}/${widget.token}",
                                  routeSettings: RouteSettings(arguments: {
                                    'doctorId': state
                                        .currentMyBookState
                                        .currentAppointment!
                                        .appointments![index]
                                        .workTime!
                                        .doctor!
                                        .doctorId,
                                    'clinicId': state
                                        .currentMyBookState
                                        .currentAppointment!
                                        .appointments![index]
                                        .workTime!
                                        .clinic!
                                        .clinicId,
                                    'token': widget.token,
                                  }),
                                );
                              },
                              child: Icon(Icons.info_outline_rounded,
                                  color: Coloring.primary2, size: 25.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Coloring.third5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Coloring.primary,
                                    size: 25.sp,
                                  ),
                                  Text(
                                      "${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.date}",
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontSize:
                                              Sizer.getWidth(context) / 25,
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Coloring.third5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Coloring.primary,
                                    size: 25.sp,
                                  ),
                                  Text(
                                      "${state.currentMyBookState.currentAppointment!.appointments![index].startingTime} ${state.currentMyBookState.currentAppointment!.appointments![index].finishingTime}",
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontSize:
                                              Sizer.getWidth(context) / 25,
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 10.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Coloring.third5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "${Font.urlImage}clinicavatar.png",
                                    width: 25.sp,
                                    height: 25.sp,
                                  ),
                                  Text(
                                      "عيادة${state.currentMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.clinicName}",
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontSize:
                                              Sizer.getWidth(context) / 25,
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )),
                            SizedBox(
                              width: 10.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CanclePage(
                                      token: widget.token!,
                                      id: state
                                          .currentMyBookState
                                          .currentAppointment!
                                          .appointments![index]
                                          .id!);
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Sizer.getWidth(context) / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Coloring.primary),
                            child: Text("إلغاء",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: state.currentMyBookState.currentAppointment!
                    .appointments!.length),
          );
        });
  }

  previousBook() {
    return BlocBuilder<MyBookBloc, MyBookState>(
        bloc: myBookBloc,
        builder: (context, state) {
          if (state.previousMyBookState.currentAppointment == null) {
            if (state.previousMyBookState.error.isNotEmpty) {
              return Center(child: Text("${state.previousMyBookState.error}"));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            color: Coloring.third3,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: state
                                            .previousMyBookState
                                            .currentAppointment!
                                            .appointments![index]
                                            .workTime!
                                            .doctor!
                                            .profilePicture ==
                                        null
                                    ? Image.asset(
                                        "${Font.urlImage}doctoravatar.png")
                                    : Image.network(state
                                        .previousMyBookState
                                        .currentAppointment!
                                        .appointments![index]
                                        .workTime!
                                        .doctor!
                                        .profilePicture!),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                        "الطبيب ${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.firstname} ${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.lastname}",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize: 20.sp,
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "اختصاص : ${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.specialty!.specialtyName}",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize:
                                                Sizer.getWidth(context) / 25,
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "عيادة ${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.clinicName}",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize:
                                                Sizer.getWidth(context) / 25,
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  RouterNav.fluroRouter.navigateTo(
                                    context,
                                    RouteName.Booking +
                                        "/${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.doctor!.doctorId}/${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.clinic!.clinicId}/${widget.token}",
                                    routeSettings: RouteSettings(arguments: {
                                      'doctorId': state
                                          .previousMyBookState
                                          .currentAppointment!
                                          .appointments![index]
                                          .workTime!
                                          .doctor!
                                          .doctorId,
                                      'clinicId': state
                                          .previousMyBookState
                                          .currentAppointment!
                                          .appointments![index]
                                          .workTime!
                                          .clinic!
                                          .clinicId,
                                      'token': widget.token,
                                    }),
                                  );
                                },
                                child: Icon(Icons.info_outline_rounded,
                                    color: Coloring.primary2, size: 25.sp),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Text("الموعد السّابق",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Coloring.primary,
                                  fontSize: Sizer.getWidth(context) / 25,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Coloring.third5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Coloring.primary,
                                      size: 25.sp,
                                    ),
                                    Text(
                                        "${state.previousMyBookState.currentAppointment!.appointments![index].workTime!.date}",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize:
                                                Sizer.getWidth(context) / 25,
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Coloring.third5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      color: Coloring.primary,
                                      size: 25.sp,
                                    ),
                                    Text(
                                        "${state.previousMyBookState.currentAppointment!.appointments![index].startingTime} - ${state.previousMyBookState.currentAppointment!.appointments![index].finishingTime} ",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize:
                                                Sizer.getWidth(context) / 25,
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 10.sp,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: Sizer.getWidth(context) / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Coloring.primary),
                            child: Text(
                                state
                                            .previousMyBookState
                                            .currentAppointment!
                                            .appointments![index]
                                            .missedAppointment ==
                                        false
                                    ? "تمت المعاينة "
                                    : "لم تتم المعاينة ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 10.sp,
                          )
                        ]));
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: state.previousMyBookState.currentAppointment!
                      .appointments!.length));
        });
  }
}
