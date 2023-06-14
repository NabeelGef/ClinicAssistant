import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/insurance.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profileDoctor.g.dart';

@JsonSerializable()
class ProfileDoctor {
  ProfileDoctor({
    this.doctorProfile,
  });

  final DoctorProfile? doctorProfile;

  factory ProfileDoctor.fromJson(Map<String, dynamic> json) =>
      _$ProfileDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDoctorToJson(this);
}

@JsonSerializable()
class DoctorProfile {
  DoctorProfile(
      {this.doctor,
      this.clinics,
      this.specialties,
      this.insurances,
      this.clinicWorkingNow,
      this.canEvaluate,
      this.tokenIsCorrect});

  final Doctors? doctor;
  final List<ClinicElement>? clinics;
  final List<Specialist>? specialties;
  final List<Insurances>? insurances;
  final bool? canEvaluate;
  final ClinicWorkingNow? clinicWorkingNow;
  final bool? tokenIsCorrect;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileToJson(this);
}

@JsonSerializable()
class ClinicWorkingNow {
  ClinicWorkingNow({
    required this.clinicId,
    required this.clinicName,
  });

  final String? clinicId;
  final String? clinicName;

  factory ClinicWorkingNow.fromJson(Map<String, dynamic> json) =>
      _$ClinicWorkingNowFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicWorkingNowToJson(this);
}


/*@JsonSerializable()
class DoctorProfile {
  DoctorProfile({
     this.doctor,
     this.clinics,
     this.specialties,
     this.insurances,
     this.clinicWorkingNow,
     this.canEvaluate,
  });

  final DoctorP? doctor;
  final List<ClinicP>? clinics;
  final List<SpecialtyP>? specialties;
  final List<Insurance>? insurances;
  final ClinicWorkingNow? clinicWorkingNow;
  final bool? canEvaluate;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => _$DoctorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileToJson(this);

}

@JsonSerializable()
class ClinicWorkingNow {
  ClinicWorkingNow({
     this.clinicId,
     this.clinicName,
  });

  final String? clinicId;
  final String? clinicName;

  factory ClinicWorkingNow.fromJson(Map<String, dynamic> json) => _$ClinicWorkingNowFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicWorkingNowToJson(this);

}

@JsonSerializable()
class ClinicP {
  ClinicP({
     this.clinicId,
     this.clinicName,
     this.phonenumber,
     this.area,
  });

  final String? clinicId;
  final String? clinicName;
  final String? phonenumber;
  final Area? area;

  factory ClinicP.fromJson(Map<String, dynamic> json) => _$ClinicPFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicPToJson(this);

}

@JsonSerializable()
class Area {
  Area({
     this.areaId,
     this.name,
     this.governorate,
  });

  final String? areaId;
  final String? name;
  final Governorate? governorate;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);

}

@JsonSerializable()
class Governorate {
  Governorate({
     this.governorateId,
     this.name,
  });

  final String? governorateId;
  final String? name;

  factory Governorate.fromJson(Map<String, dynamic> json) => _$GovernorateFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateToJson(this);

}

@JsonSerializable()
class DoctorP {
  DoctorP({
     this.doctorId,
     this.description,
     this.profilePicture,
     this.firstname,
     this.lastname,
     this.evaluate,
     this.phonenumber,
  });

  final String? doctorId;
  final String? description;
  final String? profilePicture;
  final String? firstname;
  final String? lastname;
  final String? evaluate;
  final String? phonenumber;

  factory DoctorP.fromJson(Map<String, dynamic> json) => _$DoctorPFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPToJson(this);

}

@JsonSerializable()
class Insurance {
  Insurance({
     this.insuranceId,
     this.companyName,
  });

  final String? insuranceId;
  final String? companyName;

  factory Insurance.fromJson(Map<String, dynamic> json) => _$InsuranceFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceToJson(this);

}

@JsonSerializable()
class SpecialtyP {
  SpecialtyP({
     this.specialtyId,
     this.specialtyName,
     this.subSpecialties,
  });

  final String? specialtyId;
  final String? specialtyName;
  final List<SubSpecialty>? subSpecialties;

  factory SpecialtyP.fromJson(Map<String, dynamic> json) => _$SpecialtyPFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyPToJson(this);

}

@JsonSerializable()
class SubSpecialty {
  SubSpecialty({
     this.subSpecialtyId,
     this.subSpecialtyName,
  });

  final String? subSpecialtyId;
  final String? subSpecialtyName;

  factory SubSpecialty.fromJson(Map<String, dynamic> json) => _$SubSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$SubSpecialtyToJson(this);

}*/

/*
{
	"doctor": {
		"doctorId": "14",
		"description": "حاصل على شهادة السلام العالمي في طب القلب والاوعية الدموية وجراحتها ",
		"profilePicture": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxYhCerGidsvWB476u_K2HZllmirWWZrx71O1AJ1MewUOu212GJfOffvAfBwaAPBnUuXQ&usqp=CAU",
		"firstname": "ماهر",
		"lastname": "المحمد",
		"evaluate": "3.00",
		"phonenumber": "0946612359"
	},
	"clinics": [
		{
			"clinicId": "2",
			"clinicName": "عيادة الشّفاء",
			"phonenumber": "3225878",
			"area": {
				"areaId": "42",
				"name": "المزة",
				"governorate": {
					"governorateId": "7",
					"name": "دمشق"
				}
			}
		}
	],
	"specialties": [
		{
			"specialtyId": "2",
			"specialtyName": "قلبية",
			"subSpecialties": [
				{
					"subSpecialtyId": "2",
					"subSpecialtyName": "عام"
				},
				{
					"subSpecialtyId": "6",
					"subSpecialtyName": "قثطرة"
				}
			]
		}
	],
	"insurances": [
		{
			"insuranceId": "2",
			"companyName": "شركة الصحة للتأمينات"
		}
	],
	"clinicWorkingNow": {
		"clinicId": "2",
		"clinicName": "عيادة الشّفاء"
	},
	"canEvaluate": false
}*/


















