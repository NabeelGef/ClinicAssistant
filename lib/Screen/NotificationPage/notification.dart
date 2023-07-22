import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/NotificationPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/NotificationPage/bloc/event.dart';
import 'package:clinicassistant/Screen/NotificationPage/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class NotificationPage extends StatefulWidget {
  String? token;
  NotificationPage({super.key, this.token});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  NotificationBloc notificationBloc = NotificationBloc(NotificationState(
      remainderNotificationstate:
          RemainderNotificationState(remainderNotification: null, error: ""),
      delyasAndWarningsNotificationstate: DelyasAndWarningsNotificationState(
          delaysAndWarningsNotification: null, error: "")));

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
                    child: Code.AppBarWithMyNotification(
                        _scaffoldkey, context, 'إشعاراتي ', true)),
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
                  child: Code.AppBarWithMyNotification(
                      _scaffoldkey, context, 'حجوزاتي', true)),
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
            notificationBloc
                .add(LoadingRemainderNotification(token: widget.token!));
            notificationBloc
                .add(LoadingDelaysAndWraningsEvent(token: widget.token!));
            // add Event New Notfications
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
                    child: Code.AppBarWithMyNotification(
                        _scaffoldkey, context, 'حجوزاتي ', true)),
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
                  child: Code.AppBarWithMyNotification(
                      _scaffoldkey, context, 'حجوزاتي', true)),
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
      children: [reminders(), canclingAndDelays()],
    );
  }

  canclingAndDelays() {
    return BlocBuilder<NotificationBloc, NotificationState>(
        bloc: notificationBloc,
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Coloring.third3,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: state
                                        .delyasAndWarningsNotificationstate
                                        .delaysAndWarningsNotification!
                                        .patientDelays![index]
                                        .doctor!
                                        .profilePicture ==
                                    null
                                ? Image.asset(
                                    "${Font.urlImage}doctoravatar.png")
                                : Image.network(state
                                    .delyasAndWarningsNotificationstate
                                    .delaysAndWarningsNotification!
                                    .patientDelays![index]
                                    .doctor!
                                    .profilePicture!),
                          ),
                          title: Text(
                            "الطبيب ${state.delyasAndWarningsNotificationstate.delaysAndWarningsNotification!.patientDelays![index].doctor!.firstname} ${state.delyasAndWarningsNotificationstate.delaysAndWarningsNotification!.patientDelays![index].doctor!.lastname}",
                            style: TextStyle(
                                color: Coloring.primary,
                                fontSize: 20.sp,
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "عيادة ${state.delyasAndWarningsNotificationstate.delaysAndWarningsNotification!.patientDelays![index].clinic!.clinicName}",
                            style: TextStyle(
                                color: Coloring.primary,
                                fontSize: 15.sp,
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Card(
                          color: Coloring.third2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.messenger_outlined,
                                color: Coloring.yellow,
                              ),
                              Text(
                                "${state.delyasAndWarningsNotificationstate.delaysAndWarningsNotification!.patientDelays![index].message}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: 15.sp,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Coloring.yellow,
                            ),
                            Text(
                              "${state.delyasAndWarningsNotificationstate.delaysAndWarningsNotification!.patientDelays![index].createdAt}",
                              style: TextStyle(
                                  color: Coloring.yellow,
                                  fontSize: 15.sp,
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: state.delyasAndWarningsNotificationstate
                    .delaysAndWarningsNotification!.patientDelays!.length),
          );
        });
  }

  reminders() {
    return BlocBuilder<NotificationBloc, NotificationState>(
        bloc: notificationBloc,
        builder: (context, state) {
          if (state.remainderNotificationstate.remainderNotification == null) {
            if (state.remainderNotificationstate.error!.isEmpty) {
              return Center(
                  child: CircularProgressIndicator(color: Coloring.primary2));
            } else {
              return Lottie.asset("${Font.urlLottie}notFoundAppointment.json");
            }
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Coloring.third3,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Text(
                          "لاتنسى موعدك عند الطبيب ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].doctor!.firstname} ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].doctor!.lastname} \n في عيادة  ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].clinic!.clinicName}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 15.sp,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Coloring.yellow,
                          thickness: 2,
                        ),
                        Text(
                          "${state.remainderNotificationstate.remainderNotification!.patientReminders![index].createdAt}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: 10.sp,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Sizer.getWidth(context) / 1.5,
                          child: Text(
                            "وقت الحجز \n  في يوم ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].appointment!.workTime!.day} بتاريخ   \n ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].appointment!.workTime!.date} ${state.remainderNotificationstate.remainderNotification!.patientReminders![index].appointment!.startingTime} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Coloring.primary,
                                fontSize: 15.sp,
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: state.remainderNotificationstate
                    .remainderNotification!.patientReminders!.length),
          );
        });
  }
}
