import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/doctorClinicBook.dart';
import 'package:clinicassistant/model/profileClinic.dart';
import 'package:clinicassistant/model/profileDoctor.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:dio/dio.dart';

import '../model/worktime.dart';

class API {
  //That is end points of Api
  static String BaseUrl = "https://nabee4.free.beeceptor.com/";
  static String IP = /*"192.168.43.206"*/ "10.0.2.2";
  static String BaseUrlBack = "http://$IP:3000/";
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
  static String testbook = "testbook";
  static String worktime = "work-time";
  static String appoitment = "appoitment";
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
    Doctor doctor = Doctor(doctor: []);
    Response response = await dio
        .post("$BaseUrlBack" + "$doctorsBack" + "/$alldoctorsBack", data: data);
    if (response.statusCode == 201) {
      doctor = Doctor.fromJson(response.data);
    } else if (response.statusCode == 404) {
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
      String doctorId, String clinicId, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    DoctorClinicBook doctorClinicBook = DoctorClinicBook();
    String path = "${BaseUrlBack}" +
        "$doctorsBack" +
        "/${clinicBack}" +
        "/$clinicId" +
        "/$doctorId";
    Response response = await dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      doctorClinicBook = DoctorClinicBook.fromJson(response.data);
    }

    return doctorClinicBook;
  }

  static Future<WorkTime>? getWorkTime(
      String doctorId, String clinicId, String token) async {
    WorkTime workTime = WorkTime();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    String path = "${BaseUrlBack}" +
        "$doctorsBack" +
        "/${worktime}" +
        "/$doctorId" +
        "/$clinicId";
    Response response = await dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      workTime = WorkTime.fromJson(response.data);
    }
    return workTime;
  }

  static Future<WorkTimeClock>? getWorkTimeClocks(
      String workTimeId, String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    String path = "${BaseUrlBack}" +
        "$doctorsBack" +
        "/${appoitment}" +
        "/$patientBack" +
        "/$worktime" +
        "/$workTimeId";
    print(path);
    WorkTimeClock workTimeClock = WorkTimeClock();
    Response response = await dio
        .fetch(RequestOptions(baseUrl: path, method: 'GET', headers: headers));
    if (response.statusCode == 200) {
      workTimeClock = WorkTimeClock.fromJson(response.data);
    }
    return workTimeClock;
  }

  static Future<String?>? getRemainClocks(String appointmentId) async {
    String? message;
    Response response = await dio.fetch(
      RequestOptions(
          baseUrl: "${BaseUrlBack}" +
              "${doctorsBack}" +
              "/${appoitment}" +
              "/${patientBack}" +
              "/${appointmentId}",
          method: 'GET'),
    );
    if (response.statusCode == 200) {
      message = response.data['message'];
    }
    return message;
  }

  static Future<String?>? booknow(String appointmentId, String token) async {
    String? message;
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    Response response = await dio.fetch(
      RequestOptions(
          baseUrl: "${BaseUrlBack}" +
              "${doctorsBack}" +
              "/${appoitment}" +
              "/${patientBack}" +
              "/${appointmentId}",
          headers: headers,
          method: 'POST'),
    );
    print("APPIONTMENT ID : $appointmentId");
    if (response.statusCode == 201) {
      message = response.data['mesaage'];
    }
    return message;
  }
}
