import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Screen/bookingPage/book_page.dart';
import 'package:clinicassistant/Screen/check_signup/check_signup.dart';
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

import '../../Screen/loginPage/login_page.dart';
import '../../Screen/signup/signup.dart';
import '../../Screen/signup2/signup2.dart';
import '../../test.dart';

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
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return Home(isLogin: isLogin);
  });
  static Handler alldoctors = Handler(handlerFunc: (context, parameters) {
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return AllDoctors(isLogin: isLogin);
  });
  static Handler allclinics = Handler(handlerFunc: (context, parameters) {
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return AllClinics(isLogin: isLogin);
  });

  static Handler doctorprofile = Handler(handlerFunc: (context, parameters) {
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return DoctorProfile(id: parameters['id']![0], isLogin: isLogin);
  });

  static Handler login = Handler(handlerFunc: (context, parameters) {
    return Login();
  });

  static Handler signup = Handler(handlerFunc: (context, parameters) {
    return Signup();
  });

  static Handler signup2 = Handler(handlerFunc: (context, parameters) {
    return SignUp2(
      receivedFirstName: parameters['receivedFirstName']![0],
      receivedLastName: parameters['receivedLastName']![0],
      receivedUserName: parameters['receivedUserName']![0],
      receivedPassword: parameters['receivedPassword']![0],
    );
  });

  static Handler testPage = Handler(handlerFunc: (context, parameters) {
    return Test();
  });

  static Handler clinicprofile = Handler(handlerFunc: (context, parameters) {
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return ClinicProfile(id: parameters['id']![0], isLogin: isLogin);
  });
  static Handler book = Handler(handlerFunc: (context, parameters) {
    String? isLoginParam = parameters['isLogin']?.first;
    bool isLogin = isLoginParam != null ? isLoginParam == 'true' : false;
    return BookPage(
        doctorId: parameters['doctorId']!.first,
        clinicId: parameters['clinicId']!.first,
        token: parameters['token']!.first,
        isLogin: isLogin);
  });

  static Handler checkSignUp = Handler(handlerFunc: (context, parameters) {
    return CheckSignUp(
      phoneNumberFromSignUp: parameters['phoneNumberFromSignUp']![0],
      patientId: parameters['patientId']![0],
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
    fluroRouter.define(RouteName.Home + "/:isLogin",
        handler: home, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.AllDoctors + "/:isLogin",
        handler: alldoctors, transitionType: TransitionType.nativeModal);
    fluroRouter.define(RouteName.ProfileDoctor + "/:id" + "/:isLogin",
        handler: doctorprofile);
    fluroRouter.define(RouteName.AllClinics + "/:isLogin", handler: allclinics);
    fluroRouter.define(RouteName.ProfileClinic + "/:id" + "/:isLogin",
        handler: clinicprofile);
    fluroRouter.define(
        RouteName.Booking +
            "/:doctorId" +
            "/:clinicId" +
            "/:token" +
            "/:isLogin",
        handler: book);
    fluroRouter.define(RouteName.login,
        handler: login, transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.signup,
        handler: signup, transitionType: TransitionType.inFromRight);
    fluroRouter.define(
        RouteName.checkSignUp + "/:phoneNumberFromSignUp/:patientId",
        handler: checkSignUp,
        transitionType: TransitionType.inFromRight);
    fluroRouter.define(
        RouteName.signup2 +
            "/:receivedFirstName/:receivedLastName/:receivedUserName/:receivedPassword",
        handler: signup2,
        transitionType: TransitionType.inFromRight);
    fluroRouter.define(RouteName.Home,
        handler: home, transitionType: TransitionType.inFromRight);
    fluroRouter.define("/test",
        handler: testPage, transitionType: TransitionType.nativeModal);
  }
}
