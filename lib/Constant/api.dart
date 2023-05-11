import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:dio/dio.dart';

class API{

  //That is end points of Api
  static String BaseUrl = "https://nabeelo.free.beeceptor.com/";
  static String BaseUrlBack = "http://10.0.2.2:3000/";
  static String clinicsBack = "clinics";
  static String specialist = "doctorspecialties";
  static String specialistBack = "specialties/subspecialties";
  static String clinics = "allclinics";
  static String doctors = "alldoctors";
  static String detailDoctors = "/profile";
  static Dio dio = Dio();


  //////////////////////////////////////////////////////////////////////
  // To get All Specialists From API
  static Future<Specialists> getSpecialist() async {
    Specialists specialists = Specialists();
    Response response =await  dio.get("$BaseUrlBack"+"$specialistBack");
    if(response.statusCode==200){
      //print(response.data);
      specialists =  Specialists.fromJson(response.data);
    }
    return specialists;
   }
  // To get All Clinics From API
  static Future<Clinic> getClinics() async{
     Clinic clinic = Clinic();
     Response response =await  dio.get("$BaseUrl"+"$clinics");
     if(response.statusCode==200){
       //print(response.data);
       clinic =  Clinic.fromJson(response.data);
     }
    return clinic;
   }
  // To get All Doctors From API
   static Future<Doctor> getDoctors() async{
    Doctor doctor = Doctor();
    Response response = await dio.get("$BaseUrl"+"$doctors");
    if(response.statusCode==200){
//      print(response.data);
      doctor =  Doctor.fromJson(response.data);
    }
    return doctor;
  }
  // To get Detail of Doctor From API
  static Future<Doctors> getDetailDoctor(String id ) async{
    Doctors doctorsobject = Doctors();
    Response response = await dio.get("$BaseUrl"+"$doctors"+"$detailDoctors" ,
        queryParameters: {"ID" : id});
    //print("Id : $id");
    if(response.statusCode==200){
      doctorsobject = Doctors.fromJson(response.data);
    }
    print(response.data);
    return doctorsobject;
  }
}