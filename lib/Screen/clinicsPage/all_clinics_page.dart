import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/states.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/widgets/searchBarView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/Connectivity/bloc.dart';
import '../../widgets/Connectivity/state.dart';

// ignore: must_be_immutable
class AllClinics extends StatefulWidget {
  AllClinics({Key? key}) : super(key: key);

  @override
  State<AllClinics> createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  final AllClinicsBloc allClinicsBloc = AllClinicsBloc(ClinicsStates(null, ""));
  final AllDoctorsBloc allDoctorsBloc = AllDoctorsBloc(DoctorsState(null, ""));
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void searchClicked() {
      if (form.currentState!.validate()) {
        allClinicsBloc.add(SearchEventClinic(textEditingController.text));
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
                  preferredSize: Size.fromHeight(75.sp),
                  child: SearchBarView(
                      scaffoldkey: _scaffoldkey,
                      form: form,
                      textEditingController: textEditingController,
                      isDoctor: false,
                      hint: "ابحث عن عيادتك المناسبة",
                      allDoctorsBloc: allDoctorsBloc,
                      allClinicsBloc: allClinicsBloc,
                      isConnect: false,
                      searchClicked: searchClicked),
                ),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: Code.ConnectionWidget(context, false));
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
                    hint: "ابحث عن عيادتك المناسبة",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: false,
                    searchClicked: searchClicked),
              ),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false),
            );
          }
        } else {
          if (!isLoading) {
            isLoading = true;
            allClinicsBloc.add(LoadingClinics());
          }
          if (state.getLoginState == null) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                key: _scaffoldkey,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(75.sp),
                  child: SearchBarView(
                      scaffoldkey: _scaffoldkey,
                      form: form,
                      textEditingController: textEditingController,
                      isDoctor: false,
                      hint: "ابحث عن عيادتك المناسبة",
                      allDoctorsBloc: allDoctorsBloc,
                      allClinicsBloc: allClinicsBloc,
                      isConnect: true,
                      searchClicked: searchClicked),
                ),
                endDrawer: Code.DrawerNative(context, _scaffoldkey),
                body: Code.ConnectionWidget(context, false));
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Coloring.third2,
              key: _scaffoldkey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.sp),
                child: SearchBarView(
                    scaffoldkey: _scaffoldkey,
                    form: form,
                    textEditingController: textEditingController,
                    isDoctor: true,
                    hint: "ابحث عن عيادتك المناسبة",
                    allDoctorsBloc: allDoctorsBloc,
                    allClinicsBloc: allClinicsBloc,
                    isConnect: true,
                    searchClicked: searchClicked),
              ),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: BodyClinics(),
            );
          }
        }
      });
    });
  }

  //Make Body
  Widget BodyClinics() {
    return Column(
      children: [
        SizedBox(height: 25.sp),
        Expanded(
          child: InkWell(
            onTap: () {
              RouterNav.fluroRouter
                  .navigateTo(context, RouteName.SearchByLocation);
            },
            child: Container(
              alignment: Alignment.center,
              width: Sizer.getWidth(context) / 1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Coloring.primary),
              child: Text("البحث حسب الموقع",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontFamily: Font.fontfamily,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(
          height: 25.sp,
        ),
        Expanded(
            flex: 8,
            child: Container(
                color: Coloring.third2,
                width: Sizer.getWidth(context),
                child: BlocBuilder<AllClinicsBloc, ClinicsStates>(
                    bloc: allClinicsBloc,
                    builder: (context, state) {
                      double getMainAxisExtent(double width) {
                        double mainAxisExtent = 200.0;
                        if (width > 600) {
                          mainAxisExtent = 300.0;
                        }
                        return mainAxisExtent;
                      }

                      if (state.clinic ==
                              null /*||
                          state.clinic?.clinics == null*/
                          ) {
                        if (state.error.isNotEmpty) {
                          if (state.error == "Not Found") {
                            return Center(
                                child: Lottie.asset(
                                    "${Font.urlLottie}notFound.json"));
                          }
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
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      );
                                    }),
                              ),
                              baseColor: Colors.white,
                              highlightColor: Coloring.primary);
                        }
                      } else {
                        return Container(
                            width: Sizer.getWidth(context) / 1.01,
                            child: GridView.builder(
                                padding: EdgeInsets.all(5),
                                itemCount: state.clinic!.clinics!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing:
                                            Sizer.getTextSize(context, 0.03),
                                        mainAxisSpacing:
                                            Sizer.getTextSize(context, 0.05),
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        mainAxisExtent:
                                            Sizer.getHeight(context) / 2.3),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
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
                                          flex: 6,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: Sizer.getTextSize(
                                                    context, 0.1),
                                                backgroundImage: AssetImage(
                                                    "${Font.urlImage}clinicavatar.png"),
                                              ),
                                              Center(
                                                  child: Text(
                                                      "${state.clinic!.clinics![index].clinicName}",
                                                      textAlign: TextAlign
                                                          .center,
                                                      style: TextStyle(
                                                          color:
                                                              Coloring.primary,
                                                          fontSize: Sizer
                                                              .getTextSize(
                                                                  context,
                                                                  0.05),
                                                          fontFamily:
                                                              Font.fontfamily,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Center(
                                                  child: Text(
                                                      "عدد الأطباء ${state.clinic!.clinics![index].numDoctors}",
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
                                              Center(
                                                  child: Text(
                                                """  الموقع : ${state.clinic!.clinics![index].area!.governorate!.name} - ${state.clinic!.clinics![index].area!.name}""",
                                                style: TextStyle(
                                                    color: Coloring.primary4,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Font.fontfamily,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.04)),
                                                textAlign: TextAlign.center,
                                              )),
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
                                                    'id': state
                                                        .clinic!
                                                        .clinics![index]
                                                        .clinicId,
                                                  }),
                                                  RouteName.ProfileClinic +
                                                      "/${state.clinic!.clinics![index].clinicId}");
                                            },
                                            color: Coloring.third4,
                                            child: Text("عرض التفاصيل",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.05),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        Font.fontfamily)),
                                          ),
                                        ),
                                        SizedBox(height: 25.sp)
                                      ],
                                    ),
                                  );
                                }));
                      }
                    })))
      ],
    );
  }
}
