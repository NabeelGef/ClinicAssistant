import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Screen/CanclePage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/CanclePage/bloc/event.dart';
import 'package:clinicassistant/Screen/CanclePage/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../Constant/color.dart';
import '../../Constant/sizer.dart';

// ignore: must_be_immutable
class CanclePage extends StatefulWidget {
  String id;
  String token;
  CanclePage({super.key, required this.id, required this.token});

  @override
  State<CanclePage> createState() => _CanclePageState();
}

class _CanclePageState extends State<CanclePage> {
  CancleBloc cancleBloc = CancleBloc(CancleStateAll
    (cancelStateBloc: CancelStateBloc(cancle: null, error: ""),
     cancleSuccessState: CancelSuccessState(message: null , error: "")
  ) );
  @override
  void initState() {
    cancleBloc.add(LoadingDataCancle(Id: widget.id, token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancleBloc, CancleStateAll>(
        bloc : cancleBloc,
        builder: (context, state) {
      if (state.cancelStateBloc!.cancle == null) {
        if (state.cancelStateBloc!.error!.isEmpty) {
          return AlertDialog(
              backgroundColor: Coloring.third,
              content: Center(child: CircularProgressIndicator()));
        } else {
          return AlertDialog(
            backgroundColor: Coloring.third,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            title: Column(
              children: [
                Text(
                  "هل تريد تأكيد إلغاء الحجز ؟",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                Divider(color: Colors.white)
              ],

            ),
            content: Column(
              children: [
                Lottie.asset("${Font.urlLottie}error.json",fit: BoxFit.fill),
                Text(
                    "!! انت لن تستطيع إلغاء الحجز بسبب \n بقاء أقل من نصف ساعة للموعد",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Font.fontfamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp)),

              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Sizer.getWidth(context) / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Coloring.loginWhite),
                  child: Text("إغلاق",
                      style: TextStyle(
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp)),
                ),
              ),
            ],
          );
        }
      }
      if(state.cancelStateBloc!.cancle!.cancelState!.canCancel!)
      {
        return AlertDialog(
        backgroundColor: Coloring.third,
        title: Text(
          "هل تريد تأكيد إلغاء الحجز ؟",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: Font.fontfamily,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
        content: Lottie.asset("${Font.urlLottie}logout.json"),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions:  [
                InkWell(
                  onTap: () {
                    cancleBloc.add(Cancling(Id: widget.id, token: widget.token));
                    Navigator.pop(context);
                    showDialog(context: context, builder: (context) {
                      return BlocBuilder<CancleBloc , CancleStateAll>(
                          bloc: cancleBloc,
                          builder: (context, state) {
                            if(state.cancleSuccessState==null){
                              if(state.cancleSuccessState!.error!.isNotEmpty){
                                return AlertDialog(
                                  backgroundColor: Coloring.third,
                                  title: Text("حصل خطأ",style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.underline,
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp)),
                                );
                              }else{
                                return AlertDialog(
                                  backgroundColor: Coloring.third,
                                  content:Center(child: CircularProgressIndicator(color: Colors.white)),
                                );
                              }
                            }else{
                              return AlertDialog(
                                backgroundColor: Coloring.third,
                                content: Text("تمّ إالغاء الحجز بنجاح",style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp)),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      RouterNav.fluroRouter.navigateTo(
                                          context, RouteName.MyBook + "/${  widget.token}",
                                          routeSettings: RouteSettings(arguments: {'token':widget.token}));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Sizer.getWidth(context) / 2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: Coloring.loginWhite),
                                      child: Text("إغلاق",
                                          style: TextStyle(
                                              fontFamily: Font.fontfamily,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp)),
                                    ),
                                  ),
                                ],
                              );
                            }
                          });
                    });

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
      }
      return AlertDialog(
        backgroundColor: Coloring.third,
        title: Column(
          children: [
            Text(
              "هل تريد تأكيد إلغاء الحجز ؟",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            Divider(color: Colors.white,)
          ],
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("${Font.urlLottie}logout.json"),
            Text(
              "لكن انتبه فتحذيراتك ستصبح : ${state.cancelStateBloc!.cancle!.cancelState!.numberOfMissAppointment!+1}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions:  [
          InkWell(
            onTap: () {
              cancleBloc.add(Cancling(Id: widget.id, token: widget.token));
              Navigator.pop(context);
              showDialog(context: context, builder: (context) {
                return BlocBuilder<CancleBloc , CancleStateAll>(
                    bloc: cancleBloc,
                    builder: (context, state) {
                      if(state.cancleSuccessState==null){
                        if(state.cancleSuccessState!.error!.isNotEmpty){
                          return AlertDialog(
                            backgroundColor: Coloring.third,
                            title: Text("حصل خطأ",style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp)),
                          );
                        }else{
                          return AlertDialog(
                            backgroundColor: Coloring.third,
                            content:Center(child: CircularProgressIndicator(color: Colors.white)),
                          );
                        }
                      }else{
                        return AlertDialog(
                          backgroundColor: Coloring.third,
                          content: Text("تمّ إالغاء الحجز بنجاح",style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp)),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                RouterNav.fluroRouter.navigateTo(
                                    context, RouteName.MyBook + "/${  widget.token}",
                                    routeSettings: RouteSettings(arguments: {'token':widget.token}));

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Sizer.getWidth(context) / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Coloring.loginWhite),
                                child: Text("إغلاق",
                                    style: TextStyle(
                                        fontFamily: Font.fontfamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp)),
                              ),
                            ),
                          ],
                        );
                      }
                    });
              });

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
  }
}
