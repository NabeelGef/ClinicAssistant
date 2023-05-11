import 'package:clinicassistant/model/clinic.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';

/////////////////////////////
//Model of Doctor and Doctors
/////////////////////////////


@JsonSerializable(createToJson: false)
class Doctor {
  Doctor({
     this.doctors,
  });

   List<Doctors>? doctors;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

}

@JsonSerializable(createToJson: false)
class Doctors {
  Doctors({
     this.id,
     this.profilePicture,
     this.firstName,
     this.lastName,
     this.evaluate,
     this.specialtyName,
     this.subSpecialtyName,
  });

   String? id;
   String? profilePicture;
   String? firstName;
   String? lastName;
   int? evaluate;
   String? specialtyName;
   String? subSpecialtyName;

  factory Doctors.fromJson(Map<String, dynamic> json) => _$DoctorsFromJson(json);

}
