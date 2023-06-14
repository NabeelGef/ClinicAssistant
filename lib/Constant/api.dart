import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/doctorClinicBook.dart';
import 'package:clinicassistant/model/profileClinic.dart';
import 'package:clinicassistant/model/profileDoctor.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:dio/dio.dart';

class API {
  //That is end points of Api
  static String BaseUrl = "https://nabee4.free.beeceptor.com/";
  static String BaseUrlBack = "http://10.0.2.2:3000/";
  static String clinicsBack = "clinics";
  static String patientBack = "patient";
  static String doctorsBack = "doctors";
  static String alldoctorsBack = "secondFilterDocrots";
  static String specialist = "doctorspecialties";
  static String specialistBack = "specialties/subspecialties";
  static String clinics = "allclinics";
  static String alldoctors = "alldoctors";
  static String detailDoctors = "profile";
  static String clinicBack = "clinic";
  static Dio dio = Dio();

  //////////////////////////////////////////////////////////////////////
  // To get All Specialists From API
  static Future<Specialists>? getSpecialist() async {
    Specialists specialists = Specialists();
    Response response = await dio.get("$BaseUrlBack" + "$specialistBack");
    if (response.statusCode == 200) {
      //print(response.data);
      specialists = Specialists.fromJson(response.data);
    }
    return specialists;
  }

  // To get All Clinics From API
  static Future<Clinic>? getClinics() async {
    Clinic clinic = Clinic();
    Response response = await dio.get("$BaseUrlBack" + "$clinicsBack");
    if (response.statusCode == 200) {
      //print(response.data);
      clinic = Clinic.fromJson(response.data);
    }
    return clinic;
  }

  // To get All Doctors From API
  static Future<Doctor>? getDoctors(
      bool? orderByEvaluate, int? subSpecialtyId, String? filterName) async {
    Map<String, dynamic> data = {
      'orderByEvaluate': orderByEvaluate,
      'subSpecialtyId': subSpecialtyId,
      'filterName': filterName,
    };
    Doctor doctor = Doctor(doctors: []);
    Response response = await dio
        .post("$BaseUrlBack" + "$doctorsBack" + "/$alldoctorsBack", data: data);
    if (response.statusCode == 201) {
      doctor = Doctor.fromJson(response.data);
    } else if (response.statusCode == 404) {
      print("Response 404");
      throw Exception();
    }
    return doctor;
  }

  // To get Detail of Doctor From API
  static Future<ProfileDoctor>? getDetailDoctor(String id) async {
    ProfileDoctor profileDoctor = ProfileDoctor();
    Response response = await dio
        .get("$BaseUrlBack" + "$doctorsBack" + "/$detailDoctors" + "/$id");
    if (response.statusCode == 200) {
      profileDoctor = ProfileDoctor.fromJson(response.data);
    }
    return profileDoctor;
  }

  static Future<ProfileClinic>? getDetailClinic(String id) async {
    ProfileClinic profileClinic = ProfileClinic();
    print("IDClinic : $id");
    Response response = await dio
        .get("$BaseUrlBack" + "$clinicsBack" + "/$patientBack" + "/$id");
    if (response.statusCode == 200) {
      profileClinic = ProfileClinic.fromJson(response.data);
      print("DATA CLINIC : ${response.data}");
    }
    return profileClinic;
  }

  static Future<DoctorClinicBook>? getDoctorClinicBook(
      String doctorId, String clinicId) async {
    DoctorClinicBook doctorClinicBook = DoctorClinicBook();
    Response response = await dio.get("$BaseUrlBack" +
        "$doctorsBack" +
        "/${clinicBack}" +
        "/$doctorId" +
        "/$clinicId");
    if (response.statusCode == 200) {
      doctorClinicBook = DoctorClinicBook.fromJson(response.data);
      print("BOOK : ${response.data}");
    }
    return doctorClinicBook;
  }
}
