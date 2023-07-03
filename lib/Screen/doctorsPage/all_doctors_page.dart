import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:clinicassistant/widgets/searchBarView.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/states.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AllDoctors extends StatefulWidget {
  AllDoctors({Key? key}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  final ApiSpecialistBloc apiSpecialistBloc =
      ApiSpecialistBloc(SpecialistState(null, ""));
  final AllDoctorsBloc allDoctorsBloc = AllDoctorsBloc(DoctorsState(null, ""));
  final AllClinicsBloc allClinicsBloc = AllClinicsBloc(ClinicsStates(null, ""));
  final CheckBoxBloc checkBoxBloc = CheckBoxBloc();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  int? subId;
  bool? ordering;
  String? name;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void searchClicked() {
      if (form.currentState!.validate()) {
        allDoctorsBloc
            .add(LoadingDoctors(textEditingController.text, subId, ordering));
      }
    }

    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, connect) {
      return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
        if (connect is ConnectivityInitial) {
          return Center(
              child: CircularProgressIndicator(color: Coloring.primary));
        } else if (connect is NotConnectedState) {
          isLoading = false;
          if (state.getLoginState == null) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldkey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.sp),
                child: SearchBarView(
                    scaffoldkey: _scaffoldkey,
                    form: form,
                    textEditingController: textEditingController,
                    isDoctor: true,
                    hint: "ابحث عن طبيبك المناسب",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: false,
                    searchClicked: searchClicked),
              ),
              endDrawer: Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldkey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.sp),
                child: SearchBarView(
                    scaffoldkey: _scaffoldkey,
                    form: form,
                    textEditingController: textEditingController,
                    isDoctor: true,
                    hint: "ابحث عن طبيبك المناسب",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: false,
                    searchClicked: searchClicked),
              ),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(context, _scaffoldkey)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false),
            );
          }
        } else {
          if (!isLoading) {
            isLoading = true;
            apiSpecialistBloc.add(LoadingSpecialists());
            allDoctorsBloc.add(LoadingDoctors(null, null, null));
            checkBoxBloc.SetApiSpecialBloc = apiSpecialistBloc;
            apiSpecialistBloc.SetCheckBoxBloc = checkBoxBloc;
            allDoctorsBloc.SetCheckBoxBloc = checkBoxBloc;
            print("ELSEEEE1111111111111");
          }
          if (state.getLoginState == null) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldkey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.sp),
                child: SearchBarView(
                    scaffoldkey: _scaffoldkey,
                    form: form,
                    textEditingController: textEditingController,
                    isDoctor: true,
                    hint: "ابحث عن طبيبك المناسب",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: true,
                    searchClicked: searchClicked),
              ),
              endDrawer: Code.DrawerNative(context, _scaffoldkey),
              body: BodyDoctors(state),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              key: _scaffoldkey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.sp),
                child: SearchBarView(
                    scaffoldkey: _scaffoldkey,
                    form: form,
                    textEditingController: textEditingController,
                    isDoctor: true,
                    hint: "ابحث عن طبيبك المناسب",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: true,
                    searchClicked: searchClicked),
              ),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(context, _scaffoldkey)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: BodyDoctors(state),
            );
          }
        }
      });
    });
  }

  //Make Body
  Widget BodyDoctors(SharedState sharedState) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Coloring.primary4,
                  Coloring.third2,
                ])),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ApiSpecialistBloc, SpecialistState>(
                      bloc: apiSpecialistBloc,
                      builder: (context, state) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<SubSpecialties?>(
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        value:
                                            apiSpecialistBloc.clickspecialist == -1
                                                ? null
                                                : apiSpecialistBloc.dropdownsub,
                                        isDense: true,
                                        hint: Text("الاختصاص الفرعي",
                                            style: TextStyle(
                                                color: Coloring.primary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font.fontfamily,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.04))),
                                        alignment: Alignment.center,
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.04)),
                                        icon: Icon(Icons.expand_more_rounded,
                                            color: Coloring.primary,
                                            size: Sizer.getTextSize(
                                                context, 0.09)),
                                        onChanged: (value) {
                                          int index = state
                                              .specialists!
                                              .specialties![apiSpecialistBloc
                                                  .clickspecialist]
                                              .subSpecialties!
                                              .indexOf(value!);
                                          apiSpecialistBloc.add(
                                              ChooseSubSpecialist(
                                                  value, index));
                                          subId = int.parse(state
                                              .specialists!
                                              .specialties![apiSpecialistBloc
                                                  .clickspecialist]
                                              .subSpecialties![index]
                                              .subSpecialtyId!);
                                          name =
                                              textEditingController.text.isEmpty
                                                  ? null
                                                  : textEditingController.text;

                                          allDoctorsBloc.add(LoadingDoctors(
                                              name, subId, ordering));
                                        },
                                        isExpanded: true,
                                        items: apiSpecialistBloc
                                                    .clickspecialist ==
                                                -1
                                            ? null
                                            : state
                                                .specialists!
                                                .specialties![apiSpecialistBloc
                                                    .clickspecialist]
                                                .subSpecialties!
                                                .map((sub) {
                                                return DropdownMenuItem(
                                                    value: sub,
                                                    child: Center(
                                                      child: Text(sub
                                                          .subSpecialtyName!),
                                                    ));
                                              }).toList()),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Specialist>(
                                        borderRadius: BorderRadius.circular(10),
                                        alignment: Alignment.center,
                                        dropdownColor: Colors.white,
                                        hint: Text("الاختصاص الرّئيسي",
                                            style: TextStyle(
                                                color: Coloring.primary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font.fontfamily,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.039))),
                                        isDense: true,
                                        icon: Icon(Icons.expand_more_rounded,
                                            color: Coloring.primary,
                                            size: Sizer.getTextSize(
                                                context, 0.09)),
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.04)),
                                        value: apiSpecialistBloc
                                                    .clickspecialist ==
                                                -1
                                            ? null
                                            : apiSpecialistBloc.dropdownmain,
                                        isExpanded: true,
                                        onChanged: (value) {
                                          int index = state
                                              .specialists!.specialties!
                                              .indexOf(value!);
                                          apiSpecialistBloc.add(
                                              ChooseSpecialist(index, value));
                                          subId = int.parse(state
                                              .specialists!
                                              .specialties![index]
                                              .subSpecialties![0]
                                              .subSpecialtyId!);
                                          name =
                                              textEditingController.text.isEmpty
                                                  ? null
                                                  : textEditingController.text;

                                          allDoctorsBloc.add(LoadingDoctors(
                                              name, subId, ordering));
                                        },
                                        items: state.specialists == null
                                            ? null
                                            : state.specialists!.specialties!
                                                .map((sub) {
                                                return DropdownMenuItem<
                                                        Specialist>(
                                                    value: sub,
                                                    child: Center(
                                                        child: Text(sub
                                                            .specialtyName!)));
                                              }).toList()),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5)
                            ]);
                      }),
                ),
                Expanded(
                  child: Container(
                    height: Sizer.getHeight(context) / 20,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Transform.scale(
                          scale: Sizer.getTextSize(context, 0.004),
                          child: BlocBuilder<CheckBoxBloc, List<bool>>(
                              bloc: checkBoxBloc,
                              builder: (context, state) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                      Sizer.getTextSize(context, 0.05)),
                                  child: Checkbox(
                                      side: MaterialStateBorderSide.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                                style: BorderStyle.solid);
                                          }
                                          return const BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                              style: BorderStyle.solid);
                                        },
                                      ),
                                      fillColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      checkColor: Colors.amber,
                                      value: state[0],
                                      onChanged: (value) {
                                        //print("Value : $value");
                                        /*setState(() {
                                        evaluate=value!;
                                      });*/
                                        checkBoxBloc.add(CheckEvaluate(value!));
                                        if (value) {
                                          ordering = true;
                                          name =
                                              textEditingController.text.isEmpty
                                                  ? null
                                                  : textEditingController.text;
                                          allDoctorsBloc.add(LoadingDoctors(
                                              name, subId, ordering));
                                        } else {
                                          ordering = null;
                                          name =
                                              textEditingController.text.isEmpty
                                                  ? null
                                                  : textEditingController.text;
                                          allDoctorsBloc.add(LoadingDoctors(
                                              name, subId, ordering));
                                        }
                                        //BlocProvider.of<CheckBoxBloc>(context).add(CheckEvaluate(value!));
                                      }),
                                );
                              }),
                        ),
                        Text("ترتيب حسب الأعلى تقييماً",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizer.getTextSize(context, 0.05))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: Sizer.getHeight(context) / 20,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Transform.scale(
                          scale: Sizer.getTextSize(context, 0.004),
                          child: BlocBuilder<CheckBoxBloc, List<bool>>(
                              bloc: checkBoxBloc,
                              builder: (context, state) {
                                return Padding(
                                  padding: EdgeInsets.all(
                                      Sizer.getTextSize(context, 0.05)),
                                  child: Checkbox(
                                      side: MaterialStateBorderSide.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                                style: BorderStyle.solid);
                                          }
                                          return const BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                              style: BorderStyle.solid);
                                        },
                                      ),
                                      fillColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      checkColor: Colors.amber,
                                      value: state[1],
                                      onChanged: (value) {
                                        //print("Value : $value");
                                        /*setState(() {
                                        all=value!;
                                      });*/
                                        checkBoxBloc.add(CheckAll(value!));
                                        ordering = null;
                                        subId = null;
                                        name = null;
                                        allDoctorsBloc.add(
                                            LoadingDoctors(null, null, null));
                                      }),
                                );
                              }),
                        ),
                        Text("الكل ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizer.getTextSize(context, 0.05))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Coloring.third2,
            width: Sizer.getWidth(context),
            child: BlocBuilder<AllDoctorsBloc, DoctorsState>(
                bloc: allDoctorsBloc,
                builder: (context, state) {
                  if (state.doctor == null) {
                    if (state.error.isNotEmpty) {
                      return Center(child: Text("${state.error}"));
                    } else {
                      return Shimmer.fromColors(
                          direction: ShimmerDirection.ttb,
                          loop: 10,
                          child: Container(
                            width: Sizer.getWidth(context) / 1.1,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2,
                                        mainAxisExtent:
                                            Sizer.getHeight(context) / 2.8),
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Coloring.primary,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  );
                                }),
                          ),
                          baseColor: Colors.white,
                          highlightColor: Coloring.primary);
                    }
                  } else {
                    //print("DOCTORS====>${state.doctor}");
                    return Container(
                      width: Sizer.getWidth(context) / 1.1,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: GridView.builder(
                          padding: EdgeInsets.all(15),
                          itemCount: state.doctor!.doctor.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing:
                                      Sizer.getTextSize(context, 0.03),
                                  mainAxisSpacing:
                                      Sizer.getTextSize(context, 0.05),
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisExtent:
                                      Sizer.getTextSize(context, 0.7)),
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            //int countstar = snapshot.data!.doctors![index].evaluate!.toInt();
                            return Container(
                              decoration: BoxDecoration(
                                color: Coloring.third3,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: Sizer.getWidth(context) / 10,
                                          backgroundImage: state
                                                      .doctor!
                                                      .doctor[index]
                                                      .profilePicture ==
                                                  null
                                              ? null
                                              : NetworkImage(state
                                                  .doctor!
                                                  .doctor[index]
                                                  .profilePicture!),
                                          child: state.doctor!.doctor[index]
                                                      .profilePicture ==
                                                  null
                                              ? Image.asset(
                                                  "${Font.urlImage}doctoravatar.png")
                                              : null,
                                        ),
                                        Center(
                                            child: Text(
                                                "${state.doctor!.doctor[index].firstname} ${state.doctor!.doctor[index].lastname}",
                                                style: TextStyle(
                                                    color: Coloring.primary,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Center(
                                                child: Text(
                                                    "${state.doctor!.doctor[index].specialties![0].specialtyName!}",
                                                    style: TextStyle(
                                                        color:
                                                            Coloring.primary4,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontSize:
                                                            Sizer.getTextSize(
                                                                context,
                                                                0.04)))),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text(" :التقييم",
                                                style: TextStyle(
                                                    color: Coloring.primary,
                                                    fontFamily: Font.fontfamily,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                state.doctor!.doctor[index]
                                                    .evaluate
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Coloring.primary,
                                                    fontFamily: Font.fontfamily,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              width:
                                                  Sizer.getWidth(context) / 15,
                                              height:
                                                  Sizer.getWidth(context) / 15,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                          Font.urlImage +
                                                              "star.png"))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      onPressed: () async {
                                        RouterNav.fluroRouter.navigateTo(
                                            context,
                                            routeSettings:
                                                RouteSettings(arguments: {
                                              'id': state.doctor!.doctor[index]
                                                  .doctorId,
                                              'token':
                                                  "${sharedState.getTokenState?.token}"
                                            }),
                                            RouteName.ProfileDoctor +
                                                "/${state.doctor!.doctor[index].doctorId}/${sharedState.getTokenState!.token}");
                                      },
                                      color: Coloring.third4,
                                      child: Text("عرض التفاصيل",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizer.getTextSize(
                                                  context, 0.05),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font.fontfamily)),
                                    ),
                                  ),
                                  SizedBox(height: 25.sp)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
          ),
        )
      ],
    );
  }

  //Make AppBar
  MyAppBar() {
    /*return BlocConsumer<AllDoctorsBloc , AllDoctorStates>(
        listener: (context,AllDoctorStates state) {},
        builder: (context , AllDoctorStates state) {
          bool isSearchSelected = AllDoctorsBloc.get(context).isSearch;
          return Code.AppBarDoctorsAndClinics(_scaffoldkey,context, isSearchSelected ,true,
                "ابحث عن طبيبك المناسب");
        }
    );*/
  }
}
