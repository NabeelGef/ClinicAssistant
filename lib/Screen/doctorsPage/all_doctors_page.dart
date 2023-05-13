import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/doctorProfile/doctor_profile.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({Key? key}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  final ApiSpecialistBloc apiSpecialistBloc =
      ApiSpecialistBloc(SpecialistState(null, ""));
  final AllDoctorsBloc allDoctorsBloc = AllDoctorsBloc(DoctorsState(null, ""));
  final CheckBoxBloc checkBoxBloc = CheckBoxBloc();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  void initState() {
    apiSpecialistBloc.add(LoadingSpecialists());
    allDoctorsBloc.add(LoadingDoctors());
    checkBoxBloc.SetApiSpecialBloc = apiSpecialistBloc;
    apiSpecialistBloc.SetCheckBoxBloc = checkBoxBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: MyAppBar(),
      endDrawer: Code.DrawerNative(context, _scaffoldkey),
      body: BodyDoctors(),
    );
  }

  //Make Body
  Widget BodyDoctors() {
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
                        /* if (state.specialists == null) {
                          if (state.error.isNotEmpty) {
                            return Center(child: Text("${state.error}"));
                           }
                           else {
                            return Shimmer.fromColors(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                            width:
                                                Sizer.getWidth(context) / 3,
                                            height:
                                                Sizer.getHeight(context) / 16,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                baseColor: Colors.white,
                                highlightColor: Coloring.primary4);
                          }
                        }*/
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          SizedBox(width: 5,),
                          Expanded(
                            child: DecoratedBox(
                              decoration : BoxDecoration(
                                  color : Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height : Sizer.getHeight(context)/10,

                                  child: DropdownButton(
                                  dropdownColor : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                      value:
                                          apiSpecialistBloc.clickspecialist ==
                                                  -1
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
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04)),
                                      icon: Icon(Icons.expand_more_rounded,
                                          color: Coloring.primary,
                                          size:
                                              Sizer.getTextSize(context, 0.09)),
                                      onChanged: (value) {
                                        apiSpecialistBloc
                                            .add(ChooseSubSpecialist(value!));
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
                                                  value: sub.subSpecialtyName,
                                                  child: Center(
                                                    child: Text(
                                                        sub.subSpecialtyName!),
                                                  ));
                                            }).toList()),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: DecoratedBox(
                              decoration : BoxDecoration(
                                    color : Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height : Sizer.getHeight(context)/10,
                                  child: DropdownButton<Specialist>(

                                      borderRadius: BorderRadius.circular(10),
                                      alignment: Alignment.center,
                                      dropdownColor : Colors.white,
                                      hint: Text("الاختصاص الرّئيسي",
                                          style: TextStyle(
                                              color: Coloring.primary,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: Font.fontfamily,
                                              fontSize: Sizer.getTextSize(
                                                  context, 0.04))),
                                      isDense: true,
                                      icon: Icon(Icons.expand_more_rounded,
                                          color: Coloring.primary,
                                          size:
                                              Sizer.getTextSize(context, 0.09)),
                                      style: TextStyle(
                                          color: Coloring.primary,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font.fontfamily,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.04)),
                                      value:
                                          apiSpecialistBloc.clickspecialist ==
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
                                      },
                                      items: state.specialists == null
                                          ? null
                                          : state.specialists!.specialties!
                                              .map((sub) {
                                              return DropdownMenuItem<
                                                      Specialist>(
                                                  value: sub,
                                                  child: Center(
                                                      child: Text(
                                                          sub.specialtyName!)));
                                            }).toList()),
                                ),
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
                    return Container(
                      width: Sizer.getWidth(context) / 1.1,
                      child: GridView.builder(
                        padding: EdgeInsets.all(15),
                        itemCount: state.doctor!.doctors!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: Sizer.getTextSize(context, 0.03),
                            mainAxisSpacing: Sizer.getTextSize(context, 0.05),
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisExtent: Sizer.getTextSize(context, 0.7)),
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
                                CircleAvatar(
                                  radius: Sizer.getTextSize(context, 0.1),
                                  backgroundImage: NetworkImage(state
                                      .doctor!.doctors![index].profilePicture!),
                                ),
                                Center(
                                    child: Text(
                                        "${state.doctor!.doctors![index].firstName} ${state.doctor!.doctors![index].lastName}",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.05),
                                            fontFamily: Font.fontfamily,
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Center(
                                        child: Text(
                                            " الاختصاص : ${state.doctor!.doctors![index].specialtyName!}",
                                            style: TextStyle(
                                                color: Coloring.primary4,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Font.fontfamily,
                                                fontSize: Sizer.getTextSize(
                                                    context, 0.04)))),
                                    state.doctor!.doctors![index]
                                                .subSpecialtyName !=
                                            null
                                        ? Center(
                                            child: Text(
                                                "${state.doctor!.doctors![index].subSpecialtyName!}-",
                                                style: TextStyle(
                                                    color: Coloring.primary4,
                                                    fontFamily: Font.fontfamily,
                                                    fontSize: Sizer.getTextSize(
                                                        context, 0.04))))
                                        : Center(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(" :التقييم",
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontFamily: Font.fontfamily,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.05),
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        state.doctor!.doctors![index].evaluate
                                            .toString(),
                                        style: TextStyle(
                                            color: Coloring.primary,
                                            fontFamily: Font.fontfamily,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.05),
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      width: Sizer.getWidth(context) / 15,
                                      height: Sizer.getWidth(context) / 15,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  Font.urlImage + "star.png"))),
                                    ),
                                  ],
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {},
                                  color: Coloring.third4,
                                  child: Text("عرض التفاصيل",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Sizer.getTextSize(context, 0.05),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Font.fontfamily)),
                                )
                              ],
                            ),
                          );
                        },
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
    return Code.AppBarDoctorsAndClinics(
        _scaffoldkey, context, true, "ابحث عن طبيبك المناسب");
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
