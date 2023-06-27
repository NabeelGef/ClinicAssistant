// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/widgets/AlertBook/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:clinicassistant/widgets/AlertBook/alertBookClock.dart';
import 'package:clinicassistant/widgets/AlertBook/bloc/event.dart';
import 'package:clinicassistant/widgets/AlertBook/bloc/state.dart';

import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';

// ignore: must_be_immutable
class AlertBooking extends StatefulWidget {
  String clinicName;
  String doctorId;
  String clinicId;
  String nameDoctor;
  String token;
  AlertBooking(
      {Key? key,
      required this.clinicName,
      required this.doctorId,
      required this.clinicId,
      required this.nameDoctor,
      required this.token})
      : super(key: key);

  @override
  State<AlertBooking> createState() => _AlertBooking();
}

class _AlertBooking extends State<AlertBooking> {
  GlobalKey<FormState> form = GlobalKey();
  AlertBookBloc alertBookBloc = AlertBookBloc(StateAlertBook(
      successAlertBookClock: null,
      successAlertBook: SuccessAlertBook(workTime: null, error: "")));
  TimeBloc timeBloc = TimeBloc(TimeState(
      MonthState(selecteMonth: DateTime.now().month),
      YearState(selecteYear: DateTime.now().year)));
  @override
  void initState() {
    alertBookBloc.add(LoadingEventAlertBook(
        doctorId: widget.doctorId,
        clinicId: widget.clinicId,
        token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Coloring.primary3,
      content: Container(
        width: Sizer.getWidth(context) / 1.2,
        height: Sizer.getHeight(context) / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("الحجوزات الكلّيّة",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizer.getTextSize(context, 0.06),
                    fontWeight: FontWeight.bold,
                    fontFamily: Font.fontfamily)),
            Divider(
              color: Colors.white,
            ),
            Text("في ${widget.clinicName}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizer.getTextSize(context, 0.05),
                    fontWeight: FontWeight.bold,
                    fontFamily: Font.fontfamily)),
            SizedBox(
              height: 10.sp,
            ),
            BlocBuilder<TimeBloc, TimeState>(
                bloc: timeBloc,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("السّنة",
                              style: TextStyle(
                                  color: Coloring.loginWhite,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.sp)),
                          Container(
                            width: Sizer.getWidth(context) / 4,
                            height: Sizer.getHeight(context) / 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                  borderRadius: BorderRadius.circular(10),
                                  alignment: Alignment.center,
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.expand_more_rounded,
                                      color: Coloring.primary,
                                      size: Sizer.getTextSize(context, 0.09)),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04)),
                                  value: state.yearState.selecteYear,
                                  onChanged: (value) {
                                    timeBloc
                                        .add(SelectedYearEvent(year: value!));
                                    alertBookBloc.add(
                                        LoadingEventAlertBookFilter(
                                            widget.doctorId,
                                            widget.clinicId,
                                            widget.token,
                                            state.monthState.selecteMonth
                                                .toString(),
                                            value.toString()));
                                  },
                                  isDense: true,
                                  selectedItemBuilder: (BuildContext context) {
                                    return List.generate(2, (index) {
                                      return Container(
                                        width: Sizer.getWidth(context) / 10,
                                        alignment: Alignment.center,
                                        child: Text(
                                          state.yearState.selecteYear
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  items: List.generate(2, (index) {
                                    return DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: index + 2023,
                                      child: Text(
                                        '${index + 2023}',
                                      ),
                                    );
                                  })),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("الشّهر",
                              style: TextStyle(
                                  color: Coloring.loginWhite,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.sp)),
                          Container(
                            width: Sizer.getWidth(context) / 4,
                            height: Sizer.getHeight(context) / 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                  borderRadius: BorderRadius.circular(10),
                                  alignment: Alignment.center,
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.expand_more_rounded,
                                      color: Coloring.primary,
                                      size: Sizer.getTextSize(context, 0.09)),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04)),
                                  value: state.monthState.selecteMonth,
                                  onChanged: (value) {
                                    timeBloc
                                        .add(SelectedMonthEvent(month: value!));
                                    alertBookBloc.add(
                                        LoadingEventAlertBookFilter(
                                            widget.doctorId,
                                            widget.clinicId,
                                            widget.token,
                                            value.toString(),
                                            state.yearState.selecteYear
                                                .toString()));
                                  },
                                  isDense: true,
                                  selectedItemBuilder: (BuildContext context) {
                                    return List.generate(12, (index) {
                                      return Container(
                                        width: Sizer.getWidth(context) / 10,
                                        alignment: Alignment.center,
                                        child: Text(
                                          state.monthState.selecteMonth
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  items: List.generate(12, (index) {
                                    return DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: index + 1,
                                      child: Text(
                                        '${index + 1}',
                                      ),
                                    );
                                  })),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 25.sp,
            ),
            BlocBuilder<AlertBookBloc, StateAlertBook>(
                bloc: alertBookBloc,
                builder: (context, state) {
                  if (state.successAlertBook?.workTime == null) {
                    if (state.successAlertBook!.error.isNotEmpty) {
                      return Center(
                        child: Text("${state.successAlertBook?.error}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizer.getTextSize(context, 0.06),
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily)),
                      );
                    } else {
                      return Center(
                          child:
                              CircularProgressIndicator(color: Colors.white));
                    }
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: state.successAlertBook?.workTime!
                            .doctorClinicWorkTime!.workTimes!.length,
                        itemBuilder: (context, index) {
                          bool? haveAppointments = state
                              .successAlertBook
                              ?.workTime!
                              .doctorClinicWorkTime!
                              .workTimes![index]
                              .haveAppointments!;
                          DateTime? date = state.successAlertBook?.workTime!
                              .doctorClinicWorkTime!.workTimes![index].date;
                          return InkWell(
                            onTap: () {
                              if (haveAppointments) {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    var worktime = state
                                        .successAlertBook
                                        ?.workTime!
                                        .doctorClinicWorkTime!
                                        .workTimes![index];
                                    return AlertBookClock(
                                      nameDoctor: widget.nameDoctor,
                                      nameClinic: widget.clinicName,
                                      day: worktime!.day!,
                                      date: worktime.date!,
                                      workTimeId: state
                                          .successAlertBook
                                          ?.workTime!
                                          .doctorClinicWorkTime!
                                          .workTimes![index]
                                          .workTimeId,
                                      token: widget.token,
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: haveAppointments!
                                      ? Coloring.third3
                                      : Coloring.noColor),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: Coloring.primary),
                                  Text(
                                    "${state.successAlertBook?.workTime!.doctorClinicWorkTime!.workTimes![index].day}\n" +
                                        "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                        color: Coloring.primary,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.04),
                                        fontFamily: Font.fontfamily,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: Sizer.getWidth(context) / 5,
                            mainAxisSpacing: Sizer.getWidth(context) / 25,
                            crossAxisSpacing: Sizer.getWidth(context) / 20,
                            childAspectRatio: 0.5),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
// class AlertBooking {
//   static makeAlert(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Coloring.primary3,
//       content: Container(
//         width: Sizer.getWidth(context) / 1.2,
//         height: Sizer.getHeight(context) / 2,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("الحجوزات الكلّيّة",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: Sizer.getTextSize(context, 0.06),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: Font.fontfamily)),
//             Expanded(
//               child: GridView(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisExtent: Sizer.getWidth(context) / 5,
//                     crossAxisSpacing: Sizer.getWidth(context) / 20),
//                 children: [
//                   Container(
//                     //padding: EdgeInsets.all(5.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5 الأحد",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10.sp),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: Coloring.third3),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month, color: Coloring.primary),
//                         Text(
//                           "2023-6-5",
//                           // "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
//                           //     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
//                           style: TextStyle(
//                               color: Coloring.primary,
//                               fontSize: Sizer.getTextSize(context, 0.04),
//                               fontFamily: Font.fontfamily,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
