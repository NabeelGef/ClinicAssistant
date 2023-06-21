// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:clinicassistant/widgets/AlertBook/bloc/bloc.dart';
import 'package:clinicassistant/widgets/AlertBook/bloc/event.dart';
import 'package:clinicassistant/widgets/AlertBook/bloc/state.dart';
import 'package:clinicassistant/widgets/AlertBook/bookNow.dart';

import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';

// ignore: must_be_immutable
class AlertBookClock extends StatefulWidget {
  String? workTimeId;
  String nameDoctor;
  String nameClinic;
  String day;
  DateTime date;
  String token;
  AlertBookClock(
      {Key? key,
      required this.workTimeId,
      required this.nameDoctor,
      required this.nameClinic,
      required this.day,
      required this.date,
      required this.token})
      : super(key: key);

  @override
  State<AlertBookClock> createState() => _AlertBookClockState();
}

class _AlertBookClockState extends State<AlertBookClock> {
  AlertBookBloc alertBookBloc = AlertBookBloc(StateAlertBook(
      successAlertBook: SuccessAlertBook(workTime: null, error: ""),
      successAlertBookClock:
          SuccessAlertBookClock(workTimeClock: null, error: "")));
  Appointment? appointment;
  @override
  void initState() {
    alertBookBloc.add(LoadingEventAlertBookClock(widget.workTimeId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Coloring.third,
      content: Container(
        width: Sizer.getWidth(context) / 1.2,
        height: Sizer.getHeight(context) / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "${Font.urlImage}close.png",
                    width: 25.sp,
                    height: 25.sp,
                  ),
                ),
                Text("حدّد وقتاً يناسبك",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(context, 0.06),
                        fontWeight: FontWeight.bold,
                        fontFamily: Font.fontfamily)),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 10.sp,
            ),
            BlocBuilder<AlertBookBloc, StateAlertBook>(
              bloc: alertBookBloc,
              builder: (context, state) {
                if (state.successAlertBookClock!.workTimeClock == null) {
                  if (state.successAlertBookClock!.error.isNotEmpty) {
                    return Center(
                      child: Text("${state.successAlertBookClock?.error}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizer.getTextSize(context, 0.06),
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily)),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.white));
                  }
                } else {
                  return Expanded(
                    flex: 4,
                    child: GridView.builder(
                      itemCount: state.successAlertBookClock!.workTimeClock!
                          .appointment!.length,
                      itemBuilder: (context, index) {
                        bool isBooked = state.successAlertBookClock!
                            .workTimeClock!.appointment![index].isBooked!;
                        return InkWell(
                          onTap: () {
                            if (!isBooked) {
                              appointment = state.successAlertBookClock!
                                  .workTimeClock!.appointment![index];
                              alertBookBloc.add(SelectTime(
                                  index, state.selectState!.selected));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isBooked
                                    ? Coloring.noColor
                                    : state.selectState!.selected[index][2] ==
                                            true
                                        ? Coloring.yellow
                                        : Coloring.third3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${state.successAlertBookClock!.workTimeClock!.appointment![index].startingTime}",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04),
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                isBooked
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "${Font.urlImage}error.png",
                                            width: 20.sp,
                                            height: 20.sp,
                                          ),
                                          Text(
                                            "غير متاح",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.03),
                                                fontFamily: Font.fontfamily,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: Sizer.getWidth(context) / 6,
                          mainAxisSpacing: Sizer.getWidth(context) / 20,
                          crossAxisSpacing: Sizer.getWidth(context) / 30,
                          childAspectRatio: 0.5),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20.sp,
            ),
            BlocBuilder<AlertBookBloc, StateAlertBook>(
                bloc: alertBookBloc,
                builder: (context, state) {
                  if (state.successAlertBookClock!.workTimeClock == null) {
                    if (state.successAlertBookClock!.error.isNotEmpty) {
                      return SizedBox();
                    } else {
                      return SizedBox();
                    }
                  } else {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          if (state.selectState!.myIndex != -1) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BookNow(
                                      nameDoctor: widget.nameDoctor,
                                      nameClinic: widget.nameClinic,
                                      appointmentId: appointment!.id!,
                                      day: widget.day,
                                      date: widget.date,
                                      token: widget.token);
                                });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Coloring.secondary),
                          child: Text("اختيار الحجز",
                              style: TextStyle(
                                  color: state.selectState!.myIndex == -1
                                      ? Colors.grey
                                      : Colors.white,
                                  fontSize: Sizer.getTextSize(context, 0.05),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily)),
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
