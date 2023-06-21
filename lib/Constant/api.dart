import 'package:dio/dio.dart';

class API {
  //That is end points of Api
  static String BaseUrl = "https://nabee4.free.beeceptor.com/";
  static String IP = /*"192.168.43.206"*/ "10.0.2.2";
  static String BaseUrlBack = "http://$IP:3000/";
  static String clinicsBack = "clinics";
  static String patientBack = "patient";
  static String patientsBack = "patients";
  static String signupBack = "signup";
  static String loginBack = "login";
  static String verifyBack = "verify";
  static String doctorsBack = "doctors";
  static String alldoctorsBack = "secondFilterDocrots";
  static String specialist = "doctorspecialties";
  static String specialistBack = "specialties/subspecialties";
  static String clinics = "allclinics";
  static String alldoctors = "alldoctors";
  static String detailDoctors = "profile";
  static String clinicBack = "clinic";
  static String testbook = "testbook";
  static String worktime = "work-time";
  static String appoitment = "appoitment";
  static Dio dio = Dio();
}
