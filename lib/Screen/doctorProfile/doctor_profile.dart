import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/event.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfile extends StatefulWidget {
  final String id;
  const DoctorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  DoctorProfileBloc doctorProfileBloc = DoctorProfileBloc(
      ["moredrop.png", "moredrop.png", "عرض المزيد", "moredrop.png"]);
  DoctorProfileDataBloc doctorProfileDataBloc =
      DoctorProfileDataBloc(SuccessProfileStates(null, ""));
  @override
  void initState() {
    doctorProfileDataBloc.add(LoadingProfile(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    doctorProfileDataBloc.close();
    doctorProfileBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: null, // Set your desired color here
    // ));
    return Scaffold(
        backgroundColor: Coloring.third,
        key: _scaffoldkey,
        appBar: MyAppBar(),
        endDrawer: Code.DrawerNative(context, _scaffoldkey),
        //backgroundColor: Coloring.primary,
        body: BodyDetail(context));
  }

  //Make Body
  BodyDetail(BuildContext context) {
    return SingleChildScrollView(
        child:
            /*  if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }*/
            /*else if(snapshot.hasData)*/
            BlocBuilder<DoctorProfileDataBloc, SuccessProfileStates>(
                bloc: doctorProfileDataBloc,
                builder: (context, state) {
                  if (state.profileDoctor == null) {
                    if (state.error.isNotEmpty) {
                      return Center(child: Text(state.error));
                    } else {
                      return Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange));
                    }
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 25),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Sizer.getWidth(context) / 10,
                          backgroundImage: state.profileDoctor!.doctorProfile!
                                      .doctor?.profilePicture ==
                                  null
                              ? null
                              : NetworkImage(state.profileDoctor!.doctorProfile!
                                  .doctor!.profilePicture!),
                          child: state.profileDoctor!.doctorProfile!.doctor
                                      ?.profilePicture ==
                                  null
                              ? Image.asset("${Font.urlImage}doctoravatar.png")
                              : null,
                        ),
                        Center(
                          child: Text(
                            " ${state.profileDoctor!.doctorProfile!.doctor!.firstname} "
                            "${state.profileDoctor!.doctorProfile!.doctor!.lastname} ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizer.getTextSize(context, 0.05),
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          ":الاختصاصات",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.06),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${state.profileDoctor!.doctorProfile!.specialties![0].specialtyName} "
                            "-${state.profileDoctor!.doctorProfile!.specialties![0].subSpecialties![0].subSpecialtyName} ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizer.getTextSize(context, 0.04),
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold)),
                        // if he have many subspeciality :
                        state.profileDoctor!.doctorProfile!.specialties![0]
                                    .subSpecialties!.length >
                                1
                            ? Directionality(
                                textDirection: TextDirection.rtl,
                                child: BlocBuilder<DoctorProfileBloc,
                                        List<String>>(
                                    bloc: doctorProfileBloc,
                                    builder: (context, state2) {
                                      var main = state.profileDoctor!
                                          .doctorProfile!.specialties![0];
                                      var subs = state
                                          .profileDoctor!
                                          .doctorProfile!
                                          .specialties![0]
                                          .subSpecialties!;
                                      return ExpansionTile(
                                          onExpansionChanged: (value) {
                                            doctorProfileBloc
                                                .add(ChangingMoreText(value));
                                            //print(value);
                                          },
                                          children: subs.map((e) {
                                            return Text(
                                                "${main.specialtyName} - ${e.subSpecialtyName!}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Sizer.getTextSize(
                                                      context, 0.05),
                                                  fontFamily: Font.fontfamily,
                                                  fontWeight: FontWeight.bold,
                                                ));
                                          }).toList(),
                                          trailing: Transform.translate(
                                            offset: Offset(
                                                Sizer.getWidth(context) / 4, 0),
                                            child: Image.asset(
                                                "${Font.urlImage}more.png"),
                                          ),
                                          title: Transform.translate(
                                            offset: Offset(
                                                -Sizer.getWidth(context) / 3,
                                                0),
                                            child: Text("${state2[2]}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ));
                                    }),
                              )
                            : SizedBox(),
                        Divider(color: Colors.white, thickness: 2),
                        // if active or non active :
                        state.profileDoctor?.doctorProfile!.clinicWorkingNow ==
                                null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("${Font.urlImage}offline.png"),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  Text("الطبيب غير متاح الآن ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.05),
                                        fontFamily: Font.fontfamily,
                                      )),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("${Font.urlImage}online.png"),
                                  Text.rich(TextSpan(
                                      text: " الطبيب متاح الآن في ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.05),
                                        fontFamily: Font.fontfamily,
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: "عيادة السّلام",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ])),
                                ],
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "${Font.urlImage}star.png",
                              scale: 0.4,
                            ),
                            Text(
                                "التقييم: ${state.profileDoctor!.doctorProfile!.doctor!.evaluate} ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getTextSize(context, 0.05),
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Code.showRatingBar(context);
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15.sp),
                            alignment: Alignment.center,
                            width: Sizer.getWidth(context) / 2.2,
                            height: Sizer.getHeight(context) / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(61.sp),
                                color: Coloring.primary),
                            child: Text(
                              "إضافة تقييم ",
                              style: TextStyle(
                                  fontFamily: Font.fontfamily,
                                  fontSize: Sizer.getTextSize(context, 0.05),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 15.sp),
                            child: Divider(color: Colors.white, thickness: 2)),
                        state.profileDoctor!.doctorProfile!.doctor
                                    ?.phonenumber !=
                                null
                            ? Directionality(
                                textDirection: TextDirection.rtl,
                                child: BlocBuilder<DoctorProfileBloc,
                                        List<String>>(
                                    bloc: doctorProfileBloc,
                                    builder: (context, state3) {
                                      var phone = state.profileDoctor!
                                          .doctorProfile!.doctor?.phonenumber;
                                      return ExpansionTile(
                                          tilePadding: EdgeInsets.all(10.sp),
                                          onExpansionChanged: (value) {
                                            doctorProfileBloc.add(
                                                ChangeCommunicationDropDown(
                                                    value));
                                            //print(value);
                                          },
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.phone_android_sharp,
                                                    color: Coloring.primary),
                                                Text(phone!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          Sizer.getTextSize(
                                                              context, 0.05),
                                                      fontFamily:
                                                          Font.fontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ],
                                            )
                                          ],
                                          trailing: Transform.translate(
                                              offset: Offset(
                                                  Sizer.getWidth(context) / 8,
                                                  0),
                                              child: Image.asset(
                                                  "${Font.urlImage}${state3[1]}")),
                                          title: Transform.translate(
                                            offset: Offset(
                                                -Sizer.getWidth(context) / 6,
                                                0),
                                            child: Text("عرض معلومات التّواصل",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ));
                                    }),
                              )
                            : SizedBox(),
                        Divider(color: Colors.white, thickness: 2),
                        state.profileDoctor!.doctorProfile!.doctor!
                                    .description !=
                                null
                            ? Directionality(
                                textDirection: TextDirection.rtl,
                                child: BlocBuilder<DoctorProfileBloc,
                                        List<String>>(
                                    bloc: doctorProfileBloc,
                                    builder: (context, state4) {
                                      var description = state.profileDoctor!
                                          .doctorProfile!.doctor!.description;
                                      return ExpansionTile(
                                          tilePadding: EdgeInsets.all(12.sp),
                                          onExpansionChanged: (value) {
                                            doctorProfileBloc
                                                .add(ChangeDropDown(value));
                                            //print(value);
                                          },
                                          children: [
                                            Text(description!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Sizer.getTextSize(
                                                      context, 0.05),
                                                  fontFamily: Font.fontfamily,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                          ],
                                          trailing: Transform.translate(
                                              offset: Offset(
                                                  Sizer.getWidth(context) / 8.5,
                                                  0),
                                              child: Image.asset(
                                                  "${Font.urlImage}${state4[0]}")),
                                          title: Transform.translate(
                                            offset: Offset(
                                                -Sizer.getWidth(context) / 4,
                                                0),
                                            child: Text(" نبذة عن الطبيب",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ));
                                    }),
                              )
                            : SizedBox(),
                        Divider(color: Colors.white, thickness: 2),
                        state.profileDoctor!.doctorProfile!.insurances != null
                            ? Directionality(
                                textDirection: TextDirection.rtl,
                                child: BlocBuilder<DoctorProfileBloc,
                                        List<String>>(
                                    bloc: doctorProfileBloc,
                                    builder: (context, state5) {
                                      var insurances = state.profileDoctor!
                                          .doctorProfile!.insurances!;
                                      print(insurances);
                                      return ExpansionTile(
                                          tilePadding: EdgeInsets.all(10.sp),
                                          onExpansionChanged: (value) {
                                            doctorProfileBloc.add(
                                                ChangeInsurancesDropDown(
                                                    value));
                                            //print(value);
                                          },
                                          children: insurances.map((e) {
                                            return Text(e.companyName!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Sizer.getTextSize(
                                                      context, 0.05),
                                                  fontFamily: Font.fontfamily,
                                                  fontWeight: FontWeight.bold,
                                                ));
                                          }).toList(),
                                          trailing: Transform.translate(
                                              offset: Offset(
                                                  Sizer.getWidth(context) / 8.5,
                                                  0),
                                              child: Image.asset(
                                                  "${Font.urlImage}${state5[3]}")),
                                          title: Transform.translate(
                                            offset: Offset(
                                                -Sizer.getWidth(context) / 4,
                                                0),
                                            child: Text("شركات التأمين ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ));
                                    }),
                              )
                            : Container(
                                color: Colors.orange,
                              ),
                        Divider(color: Colors.white, thickness: 2),
                        SizedBox(height: 15.sp),
                        Container(
                          height: Sizer.getHeight(context) / 3,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: state
                                .profileDoctor!.doctorProfile!.clinics!.length,
                            itemBuilder: (context, index) {
                              var clinic = state.profileDoctor!.doctorProfile!
                                  .clinics![index];
                              return Row(
                                children: [
                                  Container(
                                    width: Sizer.getWidth(context) / 2,
                                    decoration: BoxDecoration(
                                        color: Coloring.third3,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "${Font.urlImage}clinicavatar.png"),
                                        Text(clinic.clinicName!,
                                            style: TextStyle(
                                                color: Coloring.primary,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.05),
                                                fontFamily: Font.fontfamily,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${clinic.area!.governorate!.name} - "
                                            "${clinic.area!.name}",
                                            style: TextStyle(
                                              color: Coloring.primary,
                                              fontSize: Sizer.getTextSize(
                                                  context, 0.05),
                                              fontFamily: Font.fontfamily,
                                              //fontWeight: FontWeight.bold
                                            )),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          onPressed: () {
                                            RouterNav.fluroRouter.navigateTo(
                                              context,
                                              RouteName.Booking +
                                                  "/${state.profileDoctor!.doctorProfile!.doctor!.doctorId}/${state.profileDoctor!.doctorProfile!.clinics![index].clinicId}",
                                              routeSettings:
                                                  RouteSettings(arguments: {
                                                'doctorId': state
                                                    .profileDoctor!
                                                    .doctorProfile!
                                                    .doctor!
                                                    .doctorId,
                                                'clinicId': state
                                                    .profileDoctor!
                                                    .doctorProfile!
                                                    .clinics![index]
                                                    .clinicId
                                              }),
                                            );
                                            // RouterNav.fluroRouter.navigateTo(context,
                                            //     routeSettings: RouteSettings(arguments:
                                            //     {'id' : state.doctor!.doctors![index].id}),
                                            //     RouteName.ProfileDoctor+"/${state.doctor!.doctors![index].id}" );
                                          },
                                          color: Coloring.third4,
                                          child: Text("احجز الآن ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Sizer.getTextSize(
                                                      context, 0.05),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Font.fontfamily)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  )
                                ],
                              );
                            },
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      ],
                    );
                  }
                })
        /*else{
              return Text("No Data");
            }*/
        );
  }

  MyAppBar() {
    return Code.AppBarProfile(_scaffoldkey, context);
  }
}
