import 'package:clinicassistant/model/clinic.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';

/////////////////////////////
//Model of Doctor and Doctors
/////////////////////////////
@JsonSerializable()
class Doctor {
  List<Doctors>? doctors;

  Doctor({this.doctors});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return _$DoctorFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DoctorToJson(this);
  }
}
@JsonSerializable()
class Doctors {
   String? id;
   String? profilePicture;
   String? firstName;
   String? lastName;
   String? phoneNumber;
   int? evaluate;
   int? checkupPrice;
   String? specialtyName;
   bool? active;
   String? description;
   String? subSpecialtyName;
   int? numberOfPeopleWhoVoted;
   List<Clinics>? clinics;

  Doctors(
      {
         this.id,
         this.profilePicture,
         this.firstName,
         this.lastName,
         this.phoneNumber,
         this.evaluate,
         this.checkupPrice,
         this.specialtyName,
         this.active,
         this.description,
         this.subSpecialtyName,
         this.numberOfPeopleWhoVoted,
         this.clinics,
      });
   factory Doctors.fromJson(Map<String, dynamic> json) {
    return _$DoctorsFromJson(json);
   }
  Map<String, dynamic> toJson() {
   return _$DoctorsToJson(this);
  }
}
