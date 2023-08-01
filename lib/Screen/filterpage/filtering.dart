import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/filterpage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/filterpage/bloc/event.dart';
import 'package:clinicassistant/Screen/filterpage/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/model/insurance.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isLoading = false;
  int? subSpecialtyId = null;
  int? insuranceId = null;
  String? gender = null;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  FilteringBloc filteringBloc = FilteringBloc(FilteringState(
    successFilterDoctorState: SuccessFilterDoctorState(error: ''),
  ));
  FilteringBlocSpecialAndInsurance filteringBlocSpecialAndInsurance =
      FilteringBlocSpecialAndInsurance(SpecialAndInsuranceState(
          successInsurancesState: SuccessInsurancesState(error: ''),
          successSpecialistsState: SuccessSpecialistsState(error: '')));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, connect) {
      return BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          if (connect is ConnectivityInitial) {
            return Center(
                child: CircularProgressIndicator(
                    color: Coloring.loginMainContainer));
          } else if (connect is NotConnectedState) {
            isLoading = false;
            if (state.getLoginState == null) {
              return Scaffold(
                  backgroundColor: Coloring.third,
                  key: _scaffoldkey,
                  appBar: MyAppBar(null),
                  endDrawer: Code.DrawerNative(context, _scaffoldkey),
                  body: Code.ConnectionWidget(context, false));
            }
            return Scaffold(
                backgroundColor: Coloring.third,
                key: _scaffoldkey,
                appBar: MyAppBar(state.getTokenState!.token),
                endDrawer: state.getLoginState!.isLogin == true
                    ? Code.DrawerNativeSeconde(
                        context, _scaffoldkey, state.getTokenState!.token!)
                    : Code.DrawerNative(context, _scaffoldkey),
                body: Code.ConnectionWidget(context, false));
          } else {
            if (!isLoading) {
              // الاتصال ناجح مع وجود تسجيل الدخول
              isLoading = true;
              filteringBlocSpecialAndInsurance
                  .add(LoadingSpecialistsFiltring());
              filteringBlocSpecialAndInsurance.add(LoadingInsurancesFiltring());
              filteringBloc.add(LoadingDoctorsFiltirng(
                  insuranceId: null, gender: null, subSpecialtyId: null));
            }
            if (state.getLoginState == null) {
              //الاتصال ناجح مع عدم وجود تسجيل دخول
              return Scaffold(
                  backgroundColor: Coloring.third,
                  key: _scaffoldkey,
                  appBar: MyAppBar(null),
                  endDrawer: Code.DrawerNative(context, _scaffoldkey),
                  body: Filter(context, state));
            }
            return Scaffold(
                // الاتصال ناجح مع عدم وجود تسجيل دخول
                backgroundColor: Coloring.third,
                key: _scaffoldkey,
                appBar: MyAppBar(state.getTokenState!.token),
                endDrawer: state.getLoginState!.isLogin == true
                    ? Code.DrawerNativeSeconde(
                        context, _scaffoldkey, state.getTokenState!.token)
                    : Code.DrawerNative(context, _scaffoldkey),
                body: Filter(context, state));
          }
        },
      );
    });
  }

  MyAppBar(String? token) {
    return Code.AppBarProfile(_scaffoldkey, context, token);
  }

  Filter(BuildContext context, SharedState sharedstate) {
    return Column(
      children: [
        BlocBuilder<FilteringBlocSpecialAndInsurance, SpecialAndInsuranceState>(
          bloc: filteringBlocSpecialAndInsurance,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "الاختصاص الفرعي",
                          style: TextStyle(
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.r,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          width: Sizer.getWidth(context) / 2,
                          height: Sizer.getHeight(context) / 20,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<SubSpecialties?>(
                              dropdownColor: Colors.white,
                              itemHeight: 60.r,
                              borderRadius: BorderRadius.circular(10),
                              isDense: true,
                              value: filteringBlocSpecialAndInsurance
                                          .clickspecialist ==
                                      -1
                                  ? null
                                  : filteringBlocSpecialAndInsurance
                                      .subSpecialties,
                              alignment: Alignment.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.r),
                              icon: Icon(Icons.expand_more_rounded,
                                  color: Coloring.primary, size: 20.r),
                              hint: Text("الكل",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 15.r)),
                              onChanged: (value) {
                                int index = state
                                    .successSpecialistsState
                                    .specialists!
                                    .specialties![
                                        filteringBlocSpecialAndInsurance
                                            .clickspecialist]
                                    .subSpecialties!
                                    .indexOf(value!);
                                filteringBlocSpecialAndInsurance.add(
                                    ChooseSubSpecialist(
                                        index: index, sub: value));
                                subSpecialtyId = int.parse(state
                                    .successSpecialistsState
                                    .specialists!
                                    .specialties![
                                        filteringBlocSpecialAndInsurance
                                            .clickspecialist]
                                    .subSpecialties![index]
                                    .subSpecialtyId!);
                                filteringBloc.add(LoadingDoctorsFiltirng(
                                    subSpecialtyId: subSpecialtyId,
                                    insuranceId: insuranceId,
                                    gender: gender));
                              },
                              isExpanded: true,
                              items: filteringBlocSpecialAndInsurance
                                          .clickspecialist ==
                                      -1
                                  ? null
                                  : state
                                      .successSpecialistsState
                                      .specialists!
                                      .specialties![
                                          filteringBlocSpecialAndInsurance
                                              .clickspecialist]
                                      .subSpecialties!
                                      .map((sub) {
                                      return DropdownMenuItem(
                                          value: sub,
                                          child: Center(
                                            child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  sub.subSpecialtyName!,
                                                  textAlign: TextAlign.center,
                                                )),
                                          ));
                                    }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "الاختصاص الرّئيسي",
                          style: TextStyle(
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.r,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          width: Sizer.getWidth(context) / 3.5,
                          height: Sizer.getHeight(context) / 20,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Specialist?>(
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              itemHeight: 60.r,
                              value: filteringBlocSpecialAndInsurance
                                          .clickspecialist ==
                                      -1
                                  ? null
                                  : filteringBlocSpecialAndInsurance.specialist,
                              alignment: Alignment.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.r),
                              icon: Icon(Icons.expand_more_rounded,
                                  color: Coloring.primary, size: 20.r),
                              hint: Text("الكل",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 15.r)),
                              onChanged: (value) {
                                int index = state.successSpecialistsState
                                    .specialists!.specialties!
                                    .indexOf(value!);
                                filteringBlocSpecialAndInsurance.add(
                                    ChooseSpecialist(
                                        index: index, specialist: value));
                                subSpecialtyId = int.parse(state
                                    .successSpecialistsState
                                    .specialists!
                                    .specialties![index]
                                    .subSpecialties![0]
                                    .subSpecialtyId!);
                                filteringBloc.add(LoadingDoctorsFiltirng(
                                    subSpecialtyId: subSpecialtyId,
                                    insuranceId: insuranceId,
                                    gender: gender));
                              },
                              isExpanded: true,
                              items:
                                  state.successSpecialistsState.specialists ==
                                          null
                                      ? null
                                      : state.successSpecialistsState
                                          .specialists!.specialties!
                                          .map((sub) {
                                          return DropdownMenuItem(
                                              value: sub,
                                              child: Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    sub.specialtyName!,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "شركات التّامين",
                          style: TextStyle(
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.r,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          width: Sizer.getWidth(context) / 2,
                          height: Sizer.getHeight(context) / 20,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Insurances?>(
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              itemHeight: 60.r,
                              value: filteringBlocSpecialAndInsurance
                                          .insurance ==
                                      null
                                  ? null
                                  : filteringBlocSpecialAndInsurance.insurance,
                              alignment: Alignment.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.r),
                              icon: Icon(Icons.expand_more_rounded,
                                  color: Coloring.primary, size: 20.r),
                              hint: Text("الكل",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 15.r)),
                              onChanged: (value) {
                                insuranceId = int.parse(value!.insuranceId!);
                                filteringBlocSpecialAndInsurance
                                    .add(ChooseInsurance(insurance: value));
                                filteringBloc.add(LoadingDoctorsFiltirng(
                                    subSpecialtyId: subSpecialtyId,
                                    insuranceId: insuranceId,
                                    gender: gender));
                              },
                              isExpanded: true,
                              items:
                                  state.successInsurancesState.insurance == null
                                      ? null
                                      : state.successInsurancesState.insurance!
                                          .insurances!
                                          .map((ins) {
                                          return DropdownMenuItem(
                                              value: ins,
                                              child: Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    ins.companyName!,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ));
                                        }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "الجنس",
                          style: TextStyle(
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.r,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          width: Sizer.getWidth(context) / 3.5,
                          height: Sizer.getHeight(context) / 20,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String?>(
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              value: filteringBlocSpecialAndInsurance.gender ==
                                      null
                                  ? null
                                  : filteringBlocSpecialAndInsurance.gender,
                              alignment: Alignment.center,
                              style: TextStyle(
                                  color: Coloring.primary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.r),
                              icon: Icon(Icons.expand_more_rounded,
                                  color: Coloring.primary, size: 20.r),
                              hint: Text("الكل",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize: 15.r)),
                              onChanged: (value) {
                                filteringBlocSpecialAndInsurance
                                    .add(ChooseGender(gender: value!));
                                // subSpecialtyId = int.parse(state
                                //     .successSpecialistsState
                                //     .specialists!
                                //     .specialties![
                                //         filteringBlocSpecialAndInsurance
                                //             .clickspecialist]
                                //     .subSpecialties![0]
                                //     .subSpecialtyId!);
                                gender = value;
                                filteringBloc.add(LoadingDoctorsFiltirng(
                                    subSpecialtyId: subSpecialtyId,
                                    insuranceId: insuranceId,
                                    gender: gender));
                              },
                              isExpanded: true,
                              items: state.gender.map((gen) {
                                return DropdownMenuItem(
                                    value: gen,
                                    child: Center(
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            gen,
                                            textAlign: TextAlign.center,
                                          )),
                                    ));
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    filteringBlocSpecialAndInsurance.add(Reset());
                    subSpecialtyId = null;
                    insuranceId = null;
                    gender = null;
                    filteringBloc.add(LoadingDoctorsFiltirng(
                        subSpecialtyId: subSpecialtyId,
                        insuranceId: insuranceId,
                        gender: gender));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.r),
                    margin: EdgeInsets.only(top: 15.r),
                    decoration: BoxDecoration(
                        color: Coloring.third3,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("إعادة تعيين",
                        style: TextStyle(
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.r,
                            color: Coloring.primary)),
                  ),
                )
              ],
            );
          },
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.symmetric(vertical: 10.r),
          child: Text("نتائج البحث",
              style: TextStyle(
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.r,
                  color: Coloring.loginWhite)),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Coloring.primary,
            Coloring.primary2,
            Coloring.primary3
          ])),
        ),
        Expanded(
          flex: 2,
          child: BlocBuilder<FilteringBloc, FilteringState>(
              bloc: filteringBloc,
              builder: (context, state) {
                if (state.successFilterDoctorState.doctor == null) {
                  if (state.successFilterDoctorState.error.isEmpty) {
                    return Center(
                        child:
                            CircularProgressIndicator(color: Coloring.primary));
                  } else {
                    return Lottie.asset(
                        "${Font.urlLottie}notFoundAppointment.json");
                  }
                } else {
                  return ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.r,
                        );
                      },
                      shrinkWrap: true,
                      itemCount:
                          state.successFilterDoctorState.doctor!.doctor!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Coloring.third3),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                      child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25.r,
                                    backgroundImage: state
                                                .successFilterDoctorState
                                                .doctor!
                                                .doctor![index]
                                                .profilePicture ==
                                            null
                                        ? null
                                        : NetworkImage(state
                                            .successFilterDoctorState
                                            .doctor!
                                            .doctor![index]
                                            .profilePicture!),
                                    child: state
                                                .successFilterDoctorState
                                                .doctor!
                                                .doctor![index]
                                                .profilePicture ==
                                            null
                                        ? Image.asset(
                                            "${Font.urlImage}doctoravatar.png")
                                        : null,
                                  )),
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              "الطبيب ${state.successFilterDoctorState.doctor!.doctor![index].firstname} ${state.successFilterDoctorState.doctor!.doctor![index].lastname}",
                                              style: TextStyle(
                                                  fontFamily: Font.fontfamily,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25.r,
                                                  color: Coloring.primary)),
                                          Text(
                                              "اختصاص ${state.successFilterDoctorState.doctor!.doctor![index].specialties![0].specialtyName}",
                                              style: TextStyle(
                                                  fontFamily: Font.fontfamily,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.r,
                                                  color: Coloring.primary)),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "${Font.urlImage}star.png",
                                                  width: 25.r,
                                                  height: 25.r,
                                                  fit: BoxFit.fill,
                                                ),
                                                Text(
                                                    "${state.successFilterDoctorState.doctor!.doctor![index].evaluate}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Font.fontfamily,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.r,
                                                        color:
                                                            Coloring.primary))
                                              ])
                                        ],
                                      )),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        RouterNav.fluroRouter.navigateTo(
                                            context,
                                            routeSettings:
                                                RouteSettings(arguments: {
                                              'id': state
                                                  .successFilterDoctorState
                                                  .doctor!
                                                  .doctor![index]
                                                  .doctorId,
                                              'token':
                                                  "${sharedstate.getTokenState?.token}"
                                            }),
                                            RouteName.ProfileDoctor +
                                                "/${state.successFilterDoctorState.doctor!.doctor![index].doctorId}/${sharedstate.getTokenState!.token}");
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Coloring.primary2,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                }
              }),
        ),
      ],
    );
  }
}
