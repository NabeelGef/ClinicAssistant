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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AllClinics extends StatefulWidget {
  const AllClinics({Key? key}) : super(key: key);

  @override
  State<AllClinics> createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  final AllClinicsBloc allClinicsBloc = AllClinicsBloc(ClinicsStates(null, ""));
  final AllDoctorsBloc allDoctorsBloc = AllDoctorsBloc(DoctorsState(null, ""));
  @override
  void initState() {
    allClinicsBloc.add(LoadingClinics());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloring.third2,
      key: _scaffoldkey,
      appBar: MyAppBar(),
      endDrawer: Code.DrawerNative(context, _scaffoldkey),
      body: BodyClinics(),
    );
  }

  //Make AppBar
  MyAppBar() {
    return Code.AppBarDoctorsAndClinics(
        _scaffoldkey,
        form,
        context,
        textEditingController,
        false,
        "ابحث عن عيادتك المناسبة",
        allDoctorsBloc,
        allClinicsBloc);
  }

  //Make Body
  Widget BodyClinics() {
    return Column(
      children: [
        SizedBox(height: 25.sp),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          width: Sizer.getWidth(context) / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Coloring.primary),
          child: Text("البحث حسب الموقع",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizer.getTextSize(context, 0.05),
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold)),
        )),
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

                      if (state.clinic == null) {
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
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return GridView.builder(
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Coloring
                                                                .primary,
                                                            fontSize: Sizer
                                                                .getTextSize(
                                                                    context,
                                                                    0.05),
                                                            fontFamily:
                                                                Font.fontfamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                Center(
                                                    child: Text(
                                                        "عدد الأطباء ${state.clinic!.clinics![index].numDoctors}",
                                                        style: TextStyle(
                                                            color: Coloring
                                                                .primary4,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                Font.fontfamily,
                                                            fontSize: Sizer
                                                                .getTextSize(
                                                                    context,
                                                                    0.04)))),
                                                Center(
                                                    child: Text(
                                                        """  الموقع : ${state.clinic!.clinics![index].area!.governorate!.name} - ${state.clinic!.clinics![index].area!.name}
                        """,
                                                        style: TextStyle(
                                                            color: Coloring
                                                                .primary4,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                Font.fontfamily,
                                                            fontSize: Sizer
                                                                .getTextSize(
                                                                    context,
                                                                    0.04)))),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              onPressed: () {
                                                RouterNav.fluroRouter.navigateTo(
                                                    context,
                                                    routeSettings:
                                                        RouteSettings(
                                                            arguments: {
                                                          'id': state
                                                              .clinic!
                                                              .clinics![index]
                                                              .clinicId
                                                        }),
                                                    RouteName.ProfileClinic +
                                                        "/${state.clinic!.clinics![index].clinicId}");
                                              },
                                              color: Coloring.third4,
                                              child: Text("عرض التفاصيل",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          Sizer.getTextSize(
                                                              context, 0.05),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font.fontfamily)),
                                            ),
                                          ),
                                          SizedBox(height: 25.sp)
                                        ],
                                      ),
                                    );
                                  });
                            }));
                      }
                    })))
      ],
    );
  }
}