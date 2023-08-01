import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Screen/bookingPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/bookingPage/bloc/event.dart';
import 'package:clinicassistant/Screen/bookingPage/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/widgets/AlertBook/alertBook.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:clinicassistant/widgets/dialog_not_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Constant/Route/routename.dart';
import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/sizer.dart';

// ignore: must_be_immutable
class BookPage extends StatefulWidget {
  BookPage(
      {super.key,
      required this.doctorId,
      required this.clinicId,
      required this.token});
  String doctorId;
  String clinicId;
  String token;
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  BookPageBloc bookPageBloc = BookPageBloc(BookState(
      ["moredrop.png", "moredrop.png", "moredrop.png"],
      SuccessDoctorClinicBook(null, "")));
  bool isLoading = false;
  @override
  void initState() {
    print("ClicnicID : ${widget.clinicId} , DoctorID : ${widget.doctorId}");
    super.initState();
  }

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
            return Scaffold(
              key: _scaffoldkey,
              endDrawer: Code.DrawerNative(context, _scaffoldkey),
              appBar: MyAppBar(null),
              body: Code.ConnectionWidget(context, false),
            );
          }
          return Scaffold(
            key: _scaffoldkey,
            endDrawer: state.getLoginState!.isLogin == true
                ? Code.DrawerNativeSeconde(
                    context, _scaffoldkey, state.getTokenState!.token!)
                : Code.DrawerNative(context, _scaffoldkey),
            appBar: MyAppBar(state.getTokenState!.token),
            body: Code.ConnectionWidget(context, false),
          );
        } else {
          if (!isLoading) {
            isLoading = true;
            bookPageBloc.add(
                LoadingBooking(widget.doctorId, widget.clinicId, widget.token));
          }
          if (state.getLoginState == null) {
            return Scaffold(
              key: _scaffoldkey,
              endDrawer: Code.DrawerNative(context, _scaffoldkey),
              appBar: MyAppBar(null),
              backgroundColor: Coloring.third,
              body: MyBody(),
            );
          }
          return Scaffold(
            key: _scaffoldkey,
            endDrawer: state.getLoginState!.isLogin == true
                ? Code.DrawerNativeSeconde(
                    context, _scaffoldkey, state.getTokenState!.token!)
                : Code.DrawerNative(context, _scaffoldkey),
            appBar: MyAppBar(state.getTokenState!.token),
            backgroundColor: Coloring.loginWhite,
            body: MyBody(),
          );
        }
      });
    });
  }

  MyAppBar(String? token) {
    return Code.AppBarProfile(_scaffoldkey, context, token);
  }

  MyBody() {
    return SingleChildScrollView(
      child: BlocBuilder<BookPageBloc, BookState>(
          bloc: bookPageBloc,
          builder: (context, state) {
            if (state.successDoctorClinicBook.doctorClinicBook == null) {
              if (state.successDoctorClinicBook.error.isNotEmpty) {
                if (state.successDoctorClinicBook.error == "Not Found") {
                  return AlertDialogIsNotLogin();
                }
                return Center(child: Text(state.successDoctorClinicBook.error));
              } else {
                return Center(
                    child: CircularProgressIndicator(color: Coloring.primary));
              }
            } else {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset(
                              "${Font.urlImage}clinicavatar.png",
                              width: Sizer.getWidth(context) / 7.5,
                              height: Sizer.getHeight(context) / 7.5,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.clinicName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontSize: Sizer.getTextSize(context, 0.04),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: Sizer.getWidth(context) / 8,
                              backgroundImage: state
                                          .successDoctorClinicBook
                                          .doctorClinicBook!
                                          .doctorClinicDetails!
                                          .doctor!
                                          .profilePicture ==
                                      null
                                  ? null
                                  : NetworkImage(state
                                      .successDoctorClinicBook
                                      .doctorClinicBook!
                                      .doctorClinicDetails!
                                      .doctor!
                                      .profilePicture!),
                              child: state
                                          .successDoctorClinicBook
                                          .doctorClinicBook!
                                          .doctorClinicDetails!
                                          .doctor!
                                          .profilePicture ==
                                      null
                                  ? Image.asset(
                                      "${Font.urlImage}doctoravatar.png")
                                  : null,
                            ),
                            Text(
                              "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.doctor!.firstname} ${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.doctor!.lastname}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontSize: Sizer.getTextSize(context, 0.04),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.successDoctorClinicBook.doctorClinicBook!
                              .doctorClinicDetails!.isWorkingNow ==
                          true) ...[
                        Image.asset("${Font.urlImage}online.png"),
                        Text(
                          "متواجد الآن",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.04),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        )
                      ] else ...[
                        Image.asset("${Font.urlImage}offline.png"),
                        Text(
                          "غير متواجد الآن",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.04),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        )
                      ]
                    ],
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        bookPageBloc.add(ChangeCommunicationDropDown(value));
                      },
                      tilePadding: EdgeInsets.all(3.sp),
                      title: Transform.translate(
                        offset: Offset(-Sizer.getWidth(context) / 5, 0),
                        child: Text(
                          "عرض معلومات التّواصل",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.05),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Transform.translate(
                          offset: Offset(Sizer.getWidth(context) / 6, 0),
                          child: Image.asset(
                              "${Font.urlImage}${state.StatesDropDown[0]}")),
                      children: [
                        Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("${Font.urlImage}telephone.png"),
                              state
                                          .successDoctorClinicBook
                                          .doctorClinicBook!
                                          .doctorClinicDetails!
                                          .clinic!
                                          .phonenumber !=
                                      null
                                  ? Text(
                                      "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.phonenumber}",
                                      style: TextStyle(
                                          color: Coloring.third,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04),
                                          fontFamily: Font.fontfamily,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "غير متوفّر حالياً",
                                      style: TextStyle(
                                          color: Coloring.third,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04),
                                          fontFamily: Font.fontfamily,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    )
                            ])
                      ],
                    ),
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        bookPageBloc.add(ChangeSpecialDropDown(value));
                      },
                      tilePadding: EdgeInsets.all(5.sp),
                      title: Transform.translate(
                        offset: Offset(-Sizer.getWidth(context) / 5, 0),
                        child: Text(
                          "الاختصاص",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.05),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Transform.translate(
                          offset: Offset(Sizer.getWidth(context) / 6, 0),
                          child: Image.asset(
                              "${Font.urlImage}${state.StatesDropDown[1]}")),
                      children: [
                        Center(
                          child: Text(
                            "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.specialty!.specialtyName}",
                            style: TextStyle(
                                color: Coloring.third,
                                fontSize: Sizer.getTextSize(context, 0.04),
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Coloring.primary, thickness: 2),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(4.sp),
                      onExpansionChanged: (value) {
                        bookPageBloc.add(ChangeAddressDropDown(value));
                      },
                      title: Transform.translate(
                        offset: Offset(-Sizer.getWidth(context) / 5, 0),
                        child: Text(
                          "العنوان",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.05),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Transform.translate(
                          offset: Offset(Sizer.getWidth(context) / 6, 0),
                          child: Image.asset(
                              "${Font.urlImage}${state.StatesDropDown[2]}")),
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.ltr,
                            children: [
                              Icon(Icons.map, color: Coloring.primary),
                              Text(
                                "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.area!.governorate!.name} - " +
                                    "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.area!.name}",
                                style: TextStyle(
                                    color: Coloring.third,
                                    fontSize: Sizer.getTextSize(context, 0.04),
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                        InkWell(
                          onTap: () async {
                            RouterNav.fluroRouter.navigateTo(
                                context,
                                routeSettings: RouteSettings(arguments: {
                                  'id': state
                                      .successDoctorClinicBook
                                      .doctorClinicBook!
                                      .doctorClinicDetails!
                                      .clinic!
                                      .clinicId,
                                }),
                                RouteName.ProfileClinic +
                                    "/${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.clinic!.clinicId}");
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Coloring.primary),
                            child: Text(
                              "عرض موقع العيادة",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizer.getTextSize(context, 0.04),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Coloring.primary, thickness: 2),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (state
                                .successDoctorClinicBook
                                .doctorClinicBook!
                                .doctorClinicDetails!
                                .doctorClinics!
                                .checkupPrice !=
                            null) ...[
                          Column(
                            children: [
                              Text("سعر الكشفية",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04),
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Image.asset("${Font.urlImage}money.png"),
                                  SizedBox(width: 10.sp),
                                  Text(
                                      "S.P ${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.doctorClinics!.checkupPrice}",
                                      style: TextStyle(
                                          color: Coloring.third,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04),
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("مدّة المعاينة",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04),
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Image.asset("${Font.urlImage}time.png"),
                                  SizedBox(width: 10.sp),
                                  Text(
                                      "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.doctorClinics!.appointmentDuring} دقيقة",
                                      style: TextStyle(
                                          color: Coloring.third,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04),
                                          fontFamily: Font.fontfamily,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ] else ...[
                          Center(
                            child: Column(
                              children: [
                                Text("مدّة المعاينة",
                                    style: TextStyle(
                                        color: Coloring.primary,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.04),
                                        fontFamily: Font.fontfamily,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Icon(Icons.timer, color: Coloring.primary),
                                    SizedBox(width: 10.sp),
                                    Text(
                                        "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.doctorClinics!.appointmentDuring} دقيقة",
                                        style: TextStyle(
                                            color: Coloring.third,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.04),
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]
                      ]),
                  Divider(color: Colors.white, thickness: 2),
                  // Center(
                  //   child: Text("الحجوزات المتاحة",
                  //       style: TextStyle(
                  //           color: Coloring.primary,
                  //           fontSize: Sizer.getTextSize(context, 0.05),
                  //           fontFamily: Font.fontfamily,
                  //           fontWeight: FontWeight.bold)),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(15.sp),
                  //   height: Sizer.getHeight(context) / 8,
                  //   child: ListView.separated(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         DateTime? date = state
                  //             .successDoctorClinicBook
                  //             .doctorClinicBook!
                  //             .doctorClinicDetails!
                  //             .workTime![index]
                  //             .date;
                  //         return Container(
                  //           padding: EdgeInsets.all(10.sp),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(25),
                  //               color: Coloring.third3),
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.calendar_month,
                  //                   color: Coloring.primary),
                  //               Text(
                  //                 "${state.successDoctorClinicBook.doctorClinicBook!.doctorClinicDetails!.workTime![index].day} - " +
                  //                     "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
                  //                 style: TextStyle(
                  //                     color: Coloring.primary,
                  //                     fontSize:
                  //                         Sizer.getTextSize(context, 0.04),
                  //                     fontFamily: Font.fontfamily,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //       separatorBuilder: (context, index) {
                  //         return SizedBox(
                  //           width: 15.sp,
                  //         );
                  //       },
                  //       itemCount: state
                  //           .successDoctorClinicBook
                  //           .doctorClinicBook!
                  //           .doctorClinicDetails!
                  //           .workTime!
                  //           .length),
                  // ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBooking(
                              nameDoctor: state
                                      .successDoctorClinicBook
                                      .doctorClinicBook!
                                      .doctorClinicDetails!
                                      .doctor!
                                      .firstname! +
                                  state
                                      .successDoctorClinicBook
                                      .doctorClinicBook!
                                      .doctorClinicDetails!
                                      .doctor!
                                      .lastname!,
                              clinicName: state
                                  .successDoctorClinicBook
                                  .doctorClinicBook!
                                  .doctorClinicDetails!
                                  .clinic!
                                  .clinicName!,
                              doctorId: widget.doctorId,
                              clinicId: widget.clinicId,
                              token: widget.token,
                            );
                          });
                    },
                    child: Container(
                        width: Sizer.getWidth(context) / 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Coloring.third3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "عرض كل المواعيد",
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontSize: Sizer.getTextSize(context, 0.04),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Coloring.primary,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10.sp,
                  )
                ],
              );
            }
          }),
    );
  }
}
