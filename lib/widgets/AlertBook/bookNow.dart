// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/widgets/AlertBook/bloc/event.dart';
import 'package:clinicassistant/widgets/AlertBook/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';
import 'bloc/bloc.dart';

// ignore: must_be_immutable
class BookNow extends StatefulWidget {
  String nameDoctor;
  String nameClinic;
  String appointmentId;
  String day;
  DateTime date;
  BookNow({
    Key? key,
    required this.nameDoctor,
    required this.nameClinic,
    required this.appointmentId,
    required this.day,
    required this.date,
  }) : super(key: key);

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  AlertBookBloc alertBookBloc = AlertBookBloc(
      StateAlertBook(successRemain: SuccessRemain(message: null, error: "")));

  @override
  void initState() {
    alertBookBloc.add(LoadingEventRemaining(widget.appointmentId));
    super.initState();
  }

  @override
  Widget build(BuildContext contextRoot) {
    return AlertDialog(
      backgroundColor: Coloring.primary3,
      content: Container(
        width: Sizer.getWidth(contextRoot) / 1.2,
        height: Sizer.getHeight(contextRoot) / 2,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(contextRoot);
                  },
                  child: Image.asset(
                    "${Font.urlImage}close.png",
                    width: 25.sp,
                    height: 25.sp,
                  ),
                ),
                Text("تأكيد الموعد",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(contextRoot, 0.06),
                        fontWeight: FontWeight.bold,
                        fontFamily: Font.fontfamily)),
              ],
            ),
            Expanded(
              child: Center(
                child: Text("الطبيب ${widget.nameDoctor} ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(contextRoot, 0.05),
                        fontWeight: FontWeight.bold,
                        fontFamily: Font.fontfamily)),
              ),
            ),
            Expanded(
              child: Text("${widget.nameClinic}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizer.getTextSize(contextRoot, 0.05),
                      fontWeight: FontWeight.bold,
                      fontFamily: Font.fontfamily)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Coloring.third3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.calendar_month, color: Coloring.primary),
                    Text(
                      "${widget.date.year}-${widget.date.month.toString().padLeft(2, '0')}-${widget.date.day.toString().padLeft(2, '0')} - ${widget.day}",
                      style: TextStyle(
                          color: Coloring.primary,
                          fontSize: Sizer.getTextSize(contextRoot, 0.04),
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.sp,
            ),
            BlocBuilder<AlertBookBloc, StateAlertBook>(
                bloc: alertBookBloc,
                builder: (context, state) {
                  if (state.successRemain!.message == null) {
                    if (state.successRemain!.error.isNotEmpty) {
                      return SizedBox();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Coloring.third3),
                        child: Text(
                          "المتبقي : ${state.successRemain!.message}",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.04),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 35.sp,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  alertBookBloc.add(BookNowEvent(
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXRpZW50SWQiOiIyIiwidHlwZSI6NCwiaWF0IjoxNjg3MTY3MTk1LCJleHAiOjE2ODcyNTM1OTV9.GZEUfvJC4E6tZggD0J652LXePZTRXZSwbjGaZR5yuCw",
                      widget.appointmentId));
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BlocBuilder<AlertBookBloc, StateAlertBook>(
                            bloc: alertBookBloc,
                            builder: (context, state) {
                              if (state.successBook!.message == null) {
                                if (state.successBook!.error.isNotEmpty) {
                                  Navigator.pop(context);
                                  return SizedBox();
                                } else {
                                  return AlertDialog(
                                    backgroundColor: Coloring.primary,
                                    content: SizedBox(
                                      child: Row(
                                        children: <Widget>[
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 20.sp),
                                          Text(
                                            "انتظر قليلاً...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.04),
                                                fontFamily: Font.fontfamily,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                    msg: "تمّت عملية الحجز بنجاح",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Coloring.yellow,
                                    textColor: Colors.black,
                                    fontSize: 25.sp,
                                  );
                                });
                                return SizedBox();
                              }
                            });
                      });
                },
                // Navigator.pop(context);

                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Coloring.secondary),
                  child: Text("تأكيد الحجز",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
