import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/clinicProfile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/clinicProfile/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicProfile/bloc/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Constant/Route/router.dart';
import '../../main.dart';

class ClinicProfile extends StatefulWidget {
  final String id;
  ClinicProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<ClinicProfile> createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
  late CameraPosition _kGooglePlex;

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  ClinicProfileBloc clinicProfileBloc =
      ClinicProfileBloc(SuccessProfileStates(null, ""));
  @override
  void initState() {
    clinicProfileBloc.add(LoadingProfile(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      if (state.getLoginState != null) {
        return Scaffold(
          key: _scaffoldkey,
          endDrawer: Code.DrawerNative(context, _scaffoldkey),
          appBar: MyAppBar(),
          backgroundColor: Coloring.third,
          body: MyBody(state),
        );
      }
      return Scaffold(
        key: _scaffoldkey,
        endDrawer: state.getLoginState!.isLogin == true
            ? Code.DrawerNativeSeconde(context, _scaffoldkey)
            : Code.DrawerNative(context, _scaffoldkey),
        appBar: MyAppBar(),
        backgroundColor: Coloring.third,
        body: MyBody(state),
      );
    });
  }

  /*void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _moveMapToNewPosition() {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(_position!));
  }*/
  MyAppBar() {
    return Code.AppBarProfile(_scaffoldkey, context);
  }

  MyBody(SharedState sharedState) {
    return SingleChildScrollView(
        child: BlocBuilder<ClinicProfileBloc, SuccessProfileStates>(
            bloc: clinicProfileBloc,
            builder: (context, state) {
              if (state.profileClinic == null) {
                if (state.error.isNotEmpty) {
                  return Center(child: Text(state.error));
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.white));
                }
              } else {
                _kGooglePlex = CameraPosition(
                  //target:  LatLng(51.9244201, 4.4777325),
                  target: LatLng(
                      double.parse(state.profileClinic!.clinic!.latitude!),
                      double.parse(state.profileClinic!.clinic!.longitude!)),
                  zoom: 12.4746,
                );

                return Column(children: [
                  Image.asset("${Font.urlImage}clinicavatar.png"),
                  Text(state.profileClinic!.clinic!.clinicName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily)),
                  Text(
                    "اختصاص: ${state.profileClinic!.clinic!.specialty!.specialtyName!}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(context, 0.04),
                        fontFamily: Font.fontfamily,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                        //fontWeight: FontWeight.bold
                        ),
                  ),
                  state.profileClinic!.doctorWorkingNow != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("${Font.urlImage}online.png"),
                            Text(
                                "مفتوحة الأن من قبل الطبيب ${state.profileClinic!.doctorWorkingNow!.firstname} ${state.profileClinic!.doctorWorkingNow!.lastname} ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getTextSize(context, 0.04),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                          ],
                        )
                      : SizedBox(),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Coloring.primary,
                        size: 35.sp,
                      ),
                      Text("الموقع",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.06),
                              fontWeight: FontWeight.bold,
                              fontFamily: Font.fontfamily)),
                    ],
                  ),
                  //${state.profileClinic!.clinic!.area!.name}-${state.profileClinic!.clinic!.area!.governorate!.name}
                  Text(
                      "${state.profileClinic!.clinic!.area!.governorate!.name} - ${state.profileClinic!.clinic!.area!.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getTextSize(context, 0.04),
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily)),
                  GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    child: Container(
                      height: Sizer.getHeight(context) / 2,
                      width: Sizer.getWidth(context) / 1.5,
                      child: GoogleMap(
                        zoomGesturesEnabled: true,
                        onTap: (argument) {
                          print(argument);
                        },
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        markers: Set<Marker>.of([
                          Marker(
                            markerId: MarkerId('myLocation'),
                            position: LatLng(
                                double.parse(
                                    state.profileClinic!.clinic!.latitude!),
                                double.parse(
                                    state.profileClinic!.clinic!.longitude!)),
                            infoWindow: InfoWindow(
                                title:
                                    '${state.profileClinic!.clinic!.clinicName}'),
                          ),
                        ]),
                        /*onCameraMove: (CameraPosition newPosition) {
                      setState(() {
                        _position = newPosition;
                        _moveMapToNewPosition();
                      });
                    },*/
                      ),
                    ),
                  ),
                  ///////////////////////////////////SHOW MAP ////////////////////////////

                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  state.profileClinic!.clinic!.phonenumber == null
                      ? Communication(state)
                      : SizedBox(),
                  Text("الاطباء : ${state.profileClinic!.clinic!.numDoctors!}",
                      style: TextStyle(
                          color: Coloring.primary,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily)),
                  Container(
                    height: Sizer.getHeight(context) / 2.5,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.profileClinic!.doctors!.length,
                      itemBuilder: (context, index) {
                        var doctor = state.profileClinic!.doctors![index];
                        return Row(
                          children: [
                            Container(
                              width: Sizer.getWidth(context) / 2,
                              decoration: BoxDecoration(
                                  color: Coloring.third3,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: Sizer.getWidth(context) / 10,
                                    backgroundImage: state
                                                .profileClinic!
                                                .doctors![index]
                                                .profilePicture ==
                                            null
                                        ? null
                                        : NetworkImage(state.profileClinic!
                                            .doctors![index].profilePicture!),
                                    child: state.profileClinic!.doctors![index]
                                                .profilePicture ==
                                            null
                                        ? Image.asset(
                                            "${Font.urlImage}doctoravatar.png")
                                        : null,
                                  ),
                                  Text(
                                    "الطبيب ${doctor.firstname} ${doctor.lastname}",
                                    style: TextStyle(
                                        color: Coloring.primary,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.05),
                                        fontFamily: Font.fontfamily,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "اختصاص: ${state.profileClinic!.clinic!.specialty!.specialtyName!}",
                                    style: TextStyle(
                                        color: Coloring.primary,
                                        fontSize:
                                            Sizer.getTextSize(context, 0.04),
                                        fontFamily: Font.fontfamily,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold
                                        //fontWeight: FontWeight.bold
                                        ),
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
                                      Text("${doctor.evaluate}",
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
                                                    "${Font.urlImage}star.png"))),
                                      ),
                                    ],
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    onPressed: () async {
                                      if (sharedState.getTokenState!.token ==
                                          null) {
                                        print("You're not logging");
                                      } else {
                                        RouterNav.fluroRouter.navigateTo(
                                          context,
                                          RouteName.Booking +
                                              "/${state.profileClinic!.doctors![index].doctorId}/${state.profileClinic!.clinic!.clinicId}/${sharedState.getTokenState!.token}",
                                          routeSettings:
                                              RouteSettings(arguments: {
                                            'doctorId': state.profileClinic!
                                                .doctors![index].doctorId,
                                            'clinicId': state.profileClinic!
                                                .clinic!.clinicId,
                                            'token': token,
                                          }),
                                        );
                                      }
                                    },
                                    color: Coloring.third4,
                                    child: Text("احجز الآن",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Sizer.getTextSize(
                                                context, 0.05),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Font.fontfamily)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            )
                          ],
                        );
                      },
                    ),
                  )
                ]);
              }
            }));
  }

  Communication(SuccessProfileStates state) {
    return Column(
      children: [
        if (state.profileClinic!.clinic!.phonenumber != null) ...[
          Text("للتواصل",
              style: TextStyle(
                  color: Coloring.primary,
                  fontSize: Sizer.getTextSize(context, 0.05),
                  fontWeight: FontWeight.bold,
                  fontFamily: Font.fontfamily)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Coloring.primary),
              Text(state.profileClinic!.clinic!.phonenumber!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold,
                      fontFamily: Font.fontfamily))
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ] else ...[
          SizedBox()
        ]
      ],
    );
  }
}
