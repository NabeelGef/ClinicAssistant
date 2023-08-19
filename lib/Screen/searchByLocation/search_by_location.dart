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
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool isLoading = false;
  late Uint8List markerIcon;
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
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Coloring.loginWhite,
                  key: _scaffoldkey,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(100.sp),
                      child: Code.AppBarWithMyBook(_scaffoldkey, context,
                          'البحث حسب الموقع', false, null)),
                  endDrawer: Code.DrawerNative(context, _scaffoldkey),
                  body: Code.ConnectionWidget(context, false));
            }
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Coloring.loginWhite,
              key: _scaffoldkey,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100.sp),
                  child: Code.AppBarWithMyBook(_scaffoldkey, context,
                      'البحث حسب الموقع', false, state.getTokenState!.token)),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: Code.ConnectionWidget(context, false),
            );
          } else {
            if (!isLoading) {
              isLoading = true;
              searchByLocationBloc.add(AddMyLocationEvent());
              searchByLocationBloc.add(GetGovernorateEvent());
              apiSpecialistBloc.add(LoadingSpecialists());
            }
            if (state.getLoginState == null) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Coloring.loginWhite,
                  key: _scaffoldkey,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(100.sp),
                      child: Code.AppBarWithMyBook(_scaffoldkey, context,
                          'البحث حسب الموقع', false, null)),
                  endDrawer: Code.DrawerNative(context, _scaffoldkey),
                  body: BodyLocation(searchByLocationBloc));
            }
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Coloring.loginWhite,
              key: _scaffoldkey,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100.sp),
                  child: Code.AppBarWithMyBook(_scaffoldkey, context,
                      'البحث حسب الموقع', false, state.getTokenState!.token)),
              endDrawer: state.getLoginState!.isLogin == true
                  ? Code.DrawerNativeSeconde(
                      context, _scaffoldkey, state.getTokenState!.token!)
                  : Code.DrawerNative(context, _scaffoldkey),
              body: BodyLocation(searchByLocationBloc),
            );
          }
        },
      );
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
              return Center(
                  child: CircularProgressIndicator(color: Coloring.primary));
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
            print("LAt : ${lat} , ${long}");
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
                      width: Sizer.getWidth(context) / 2.1,
                      child: Card(
                        elevation: 15.sp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
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
                              searchByLocationBloc.add(
                                  ChangeDropDownAreaEvent(dropdown: value!));
                            },
                            items: state.getAreaState.allArea == null
                                ? null
                                : state.getAreaState.allArea!.areas!
                                    .map((item) {
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
                    ),
                    Container(
                      width: Sizer.getWidth(context) / 2.1,
                      child: Card(
                        elevation: 15.sp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
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
                            value:
                                searchByLocationBloc.dropdowngovernate == null
                                    ? null
                                    : searchByLocationBloc.dropdowngovernate,
                            onChanged: (value) {
                              searchByLocationBloc.add(
                                  ChangeDropDownGovernorateEvent(
                                      dropdown: value!));
                            },
                            items: state.getGovernorateState.allGovernorate!
                                .governorates!
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
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 15.sp,
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
                                    itemHeight: 60.r,
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
                                                  sub.specialtyName!,
                                                  textAlign: TextAlign.center,
                                                )));
                                          }).toList()),
                              ),
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
                      child: Card(
                        elevation: 15.sp,
                        color: state.isClickArea == null ||
                                state.isClickArea == false
                            ? Colors.white
                            : Coloring.third3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )),
                        child: InkWell(
                          onTap: () {
                            if (searchByLocationBloc.dropdownareas == null) {
                              Fluttertoast.showToast(
                                  msg: "يجب إدخال منطقة محددة",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);
                            } else if (apiSpecialistBloc.dropdownmain == null) {
                              Fluttertoast.showToast(
                                  msg: "يجب إدخال اختصاص محدّد",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);
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
                      child: Card(
                        elevation: 15.sp,
                        color: state.isClickArea == null ||
                                state.isClickArea == true
                            ? Colors.white
                            : Coloring.third3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: InkWell(
                          onTap: () {
                            if (apiSpecialistBloc.dropdownmain == null) {
                              Fluttertoast.showToast(
                                  msg: "يجب إدخال اختصاص محدّد",
                                  toastLength: Toast.LENGTH_LONG,
                                  textColor: Colors.white,
                                  backgroundColor: Coloring.primary);
                            } else {
                              searchByLocationBloc.add(SearchByMYLocationEvent(
                                  Latitude: state.Mylocation!
                                      .latitude,
                                      //33.533652000000, // Default Lat
                                  Longitude: state.Mylocation!
                                      .longitude,
                                      //36.235538000000000, // Default Long
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
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueBlue),
                                    markerId:
                                        MarkerId('myLocation${e.clinicId}'),
                                    position: LatLng(double.parse(e.latitude!),
                                        double.parse(e.longitude!)),
                                    infoWindow: InfoWindow(
                                        title: '${e.clinicName} ',
                                        snippet:
                                            "${apiSpecialistBloc.dropdownmain?.specialtyName}"),
                                  );
                                }).toList(),
                              )
                            : Set(),
                        myLocationEnabled: true, // Enable my location button
                        myLocationButtonEnabled: true),
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
