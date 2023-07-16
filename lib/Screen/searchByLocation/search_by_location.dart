import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/Screen/searchByLocation/bloc/event.dart';
import 'package:clinicassistant/Screen/searchByLocation/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bloc/bloc.dart';

class SearchByLocation extends StatefulWidget {
  const SearchByLocation({super.key});

  @override
  State<SearchByLocation> createState() => _SearchByLocationState();
}

class _SearchByLocationState extends State<SearchByLocation> {
  final ApiSpecialistBloc apiSpecialistBloc =
      ApiSpecialistBloc(SpecialistState(null, ""));
  SearchByLocationBloc searchByLocationBloc = SearchByLocationBloc(
      SearchByLocationState(
          GetGovernorateState(
              dropdowngovernate: null, allGovernorate: null, error: ""),
          GetAreaState(dropdownarea: null, allArea: null, error: ""),
          GetClinicState(clinic: null, error: ""),
          null,
          null));
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  void initState() {
    searchByLocationBloc.add(AddMyLocationEvent());
    searchByLocationBloc.add(GetGovernorateEvent());
    apiSpecialistBloc.add(LoadingSpecialists());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      if (state.getLoginState == null) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Coloring.third2,
          key: _scaffoldkey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.sp),
              child: Code.AppBarWithText(
                  _scaffoldkey, context, 'البحث حسب الموقع', false)),
          endDrawer: Code.DrawerNative(context, _scaffoldkey),
          body: BodyLocation(searchByLocationBloc),
        );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Coloring.third2,
          key: _scaffoldkey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.sp),
              child: Code.AppBarWithText(
                  _scaffoldkey, context, 'البحث حسب الموقع', false)),
          endDrawer: state.getLoginState!.isLogin == true
              ? Code.DrawerNativeSeconde(context, _scaffoldkey)
              : Code.DrawerNative(context, _scaffoldkey),
          body: BodyLocation(searchByLocationBloc),
        );
      }
    });
  }

  BodyLocation(SearchByLocationBloc searchByLocationBloc) {
    GoogleMapController? mapController;
    //target:  LatLng(51.9244201, 4.4777325),35.02063448090208, 38.558091991880914
    var _kGooglePlex = CameraPosition(
      target: LatLng(double.parse("35.02063448090208"),
          double.parse("38.558091991880914")),
      zoom: 7.47,
    );

    return BlocBuilder<SearchByLocationBloc, SearchByLocationState>(
        bloc: searchByLocationBloc,
        builder: (context, state) {
          if (state.getGovernorateState.allGovernorate == null) {
            if (state.getGovernorateState.error!.isNotEmpty) {
              return Center(
                  child: Text(state.getGovernorateState.error!,
                      style: TextStyle(
                          fontFamily: Font.fontfamily,
                          fontSize: 25.sp,
                          color: Colors.white)));
            } else {
              return CircularProgressIndicator(color: Colors.white);
            }
          }
          double? lat;
          double? long;

          if (state.getClinicState.clinic == null) {
            lat = double.parse("35.02063448090208");
            long = double.parse("38.558091991880914");
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 7.47,
                ),
              ),
            );
          } else {
            lat = double.parse(
                state.getClinicState.clinic!.clinics![0].latitude!);
            long = double.parse(
                state.getClinicState.clinic!.clinics![0].longitude!);
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 12,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: Sizer.getWidth(context) / 2.1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Area>(
                          alignment: Alignment.center,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Coloring.primary,
                            size: 35.sp,
                          ),
                          menuMaxHeight: Sizer.getHeight(context) / 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily,
                              fontSize: Sizer.getTextSize(context, 0.04)),
                          hint: Text("تحديد المنطقة ",
                              style: TextStyle(
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          value: searchByLocationBloc.dropdownareas == null
                              ? null
                              : searchByLocationBloc.dropdownareas,
                          onChanged: (value) {
                            searchByLocationBloc
                                .add(ChangeDropDownAreaEvent(dropdown: value!));
                          },
                          items: state.getAreaState.allArea == null
                              ? null
                              : state.getAreaState.allArea!.areas!.map((item) {
                                  return DropdownMenuItem<Area>(
                                    value: item,
                                    child: Center(
                                      child: Text(
                                        item.name!,
                                      ),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: Sizer.getWidth(context) / 2.1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Governorate>(
                          alignment: Alignment.center,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Coloring.primary,
                            size: 35.sp,
                          ),
                          menuMaxHeight: Sizer.getHeight(context) / 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily,
                              fontSize: Sizer.getTextSize(context, 0.04)),
                          hint: Text("تحديد المحافظة",
                              style: TextStyle(
                                  fontFamily: Font.fontfamily,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          value: searchByLocationBloc.dropdowngovernate == null
                              ? null
                              : searchByLocationBloc.dropdowngovernate,
                          onChanged: (value) {
                            searchByLocationBloc.add(
                                ChangeDropDownGovernorateEvent(
                                    dropdown: value!));
                          },
                          items: state
                              .getGovernorateState.allGovernorate!.governorates!
                              .map((item) {
                            return DropdownMenuItem<Governorate>(
                              value: item,
                              child: Center(
                                child: Text(
                                  item.name!,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                BlocBuilder<ApiSpecialistBloc, SpecialistState>(
                    bloc: apiSpecialistBloc,
                    builder: (context, statespecial) {
                      return Column(
                        children: [
                          Container(
                            width: Sizer.getWidth(context) / 2.1,
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
                                  icon: Icon(Icons.expand_more_rounded,
                                      color: Coloring.primary,
                                      size: Sizer.getTextSize(context, 0.09)),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font.fontfamily,
                                      fontSize:
                                          Sizer.getTextSize(context, 0.04)),
                                  value: apiSpecialistBloc.dropdownmain,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    int index = -1;
                                    apiSpecialistBloc
                                        .add(ChooseSpecialist(index, value!));
                                  },
                                  items: statespecial.specialists == null
                                      ? null
                                      : statespecial.specialists!.specialties!
                                          .map((sub) {
                                          return DropdownMenuItem<Specialist>(
                                              value: sub,
                                              child: Center(
                                                  child: Text(
                                                      sub.specialtyName!)));
                                        }).toList()),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                        ],
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                            color: state.isClickArea == null ||
                                    state.isClickArea == false
                                ? Colors.white
                                : Coloring.third3),
                        child: InkWell(
                          onTap: () {
                            if (searchByLocationBloc.dropdownareas == null) {
                             /* Fluttertoast.showToast(
                                  msg: "يجب إدخال منطقة محددة",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);*/
                            } else if (apiSpecialistBloc.dropdownmain == null) {
                              /*Fluttertoast.showToast(
                                  msg: "يجب إدخال اختصاص محدّد",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);*/
                            } else {
                              searchByLocationBloc.add(SearchByLocationEvent(
                                  areaId: searchByLocationBloc
                                      .dropdownareas!.areaId!,
                                  specialId: apiSpecialistBloc
                                      .dropdownmain!.specialtyId!));
                            }
                          },
                          child: Text(
                            "ابحث حسب المنطقة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Coloring.secondary,
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                            color: state.isClickArea == null ||
                                    state.isClickArea == true
                                ? Colors.white
                                : Coloring.third3),
                        child: InkWell(
                          onTap: () {
                            if (apiSpecialistBloc.dropdownmain == null) {
                             /* Fluttertoast.showToast(
                                  msg: "يجب إدخال اختصاص محدّد",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);*/
                            } else {
                              searchByLocationBloc.add(SearchByMYLocationEvent(
                                  Latitude: 33.48970433857038, // Default Lat
                                  Longitude: 36.28592427251614, // Default Long
                                  specialId: apiSpecialistBloc
                                      .dropdownmain!.specialtyId!));
                            }
                          },
                          child: Text(
                            "ابحث حسب موقعك",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Coloring.secondary,
                                fontWeight: FontWeight.bold,
                                fontFamily: Font.fontfamily,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  child: Container(
                    height: Sizer.getHeight(context) / 2,
                    width: Sizer.getWidth(context) / 1.1,
                    child: GoogleMap(
                        onMapCreated: (controller) {
                          mapController = controller;
                        },
                        zoomGesturesEnabled: true,
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        markers: state.getClinicState.clinic != null
                            ? Set<Marker>.of(
                                state.getClinicState.clinic!.clinics!.map((e) {
                                  return Marker(
                                    markerId:
                                        MarkerId('myLocation${e.clinicId}'),
                                    position: LatLng(double.parse(e.latitude!),
                                        double.parse(e.longitude!)),
                                    infoWindow:
                                        InfoWindow(title: '${e.clinicName}'),
                                  );
                                }).toList(),
                              )
                            : Set()),
                  ),
                ),
                SizedBox(
                  height: 25.sp,
                )
              ],
            ),
          );
        });
  }
}
