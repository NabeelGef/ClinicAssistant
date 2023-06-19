import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Screen/bookingPage/book_page.dart';
import 'package:clinicassistant/Screen/clinicProfile/clinic_profile.dart';
import 'package:clinicassistant/Screen/clinicsPage/all_clinics_page.dart';
import 'package:clinicassistant/Screen/doctorProfile/doctor_profile.dart';
import 'package:clinicassistant/Screen/doctorsPage/all_doctors_page.dart';
import 'package:clinicassistant/Screen/homePage/home.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom0.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom4.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome1.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome2.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome3.dart';
import 'package:fluro/fluro.dart';

class RouterNav {
  static FluroRouter fluroRouter = FluroRouter();
  static Handler welcome0 = Handler(handlerFunc: (context, parameters) {
    return Welcome0();
  });
  static Handler welcome1 = Handler(handlerFunc: (context, parameters) {
    return Welcome1();
  });
  static Handler welcome2 = Handler(handlerFunc: (context, parameters) {
    return Welcome2();
  });
  static Handler welcome3 = Handler(handlerFunc: (context, parameters) {
    return Welcome3();
  });
  static Handler welcome4 = Handler(handlerFunc: (context, parameters) {
    return Welcome4();
  });
  static Handler home = Handler(handlerFunc: (context, parameters) {
    return Home();
  });
  static Handler alldoctors = Handler(handlerFunc: (context, parameters) {
    return AllDoctors();
  });
  static Handler allclinics = Handler(handlerFunc: (context, parameters) {
    return AllClinics();
  });

  static Handler doctorprofile = Handler(handlerFunc: (context, parameters) {
    return DoctorProfile(id: parameters['id']![0]);
  });
  static Handler clinicprofile = Handler(handlerFunc: (context, parameters) {
    return ClinicProfile(id: parameters['id']![0]);
  });
  static Handler book = Handler(handlerFunc: (context, parameters) {
    return BookPage(
      doctorId: parameters['doctorId']!.first,
      clinicId: parameters['clinicId']!.first,
    );
  });

  static void setupRouter() {
    fluroRouter.define(RouteName.welcome0,
        handler: welcome0, transitionType: TransitionType.fadeIn);
    fluroRouter.define(RouteName.welcome1,
        handler: welcome1, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.welcome2,
        handler: welcome2, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.welcome3,
        handler: welcome3, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.welcome4,
        handler: welcome4, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.Home,
        handler: home, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.AllDoctors,
        handler: alldoctors, transitionType: TransitionType.nativeModal);
    fluroRouter.define(RouteName.ProfileDoctor + "/:id",
        handler: doctorprofile);
    fluroRouter.define(RouteName.AllClinics, handler: allclinics);
    fluroRouter.define(RouteName.ProfileClinic + "/:id",
        handler: clinicprofile);
    fluroRouter.define(RouteName.Booking + "/:doctorId" + "/:clinicId",
        handler: book);
  }
}