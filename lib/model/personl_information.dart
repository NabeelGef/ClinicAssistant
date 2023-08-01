import 'package:json_annotation/json_annotation.dart';

part 'personl_information.g.dart';

@JsonSerializable()
class Patient {
  Patient({
     this.patient,
  });

  final PatientElement? patient;

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

}

@JsonSerializable()
class PatientElement {
  PatientElement({
    required this.patientId,
    required this.gender,
    required this.phoneNumber,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
    required this.birthDate,
    required this.numberOfMissAppointment,
  });

  final String? patientId;
  final String? gender;
  final String? phoneNumber;
  final String? firstname;
  final String? lastname;
  final String? profilePicture;
  final String? birthDate;
  final int? numberOfMissAppointment;

  factory PatientElement.fromJson(Map<String, dynamic> json) => _$PatientElementFromJson(json);

  Map<String, dynamic> toJson() => _$PatientElementToJson(this);

}

/*
{
	"patient": {
		"patientId": "1",
		"gender": "ذكر",
		"phoneNumber": "0967122753",
		"firstname": "نبيلو",
		"lastname": "المرضان",
		"profilePicture": null,
		"birthDate": "2000-08-22",
		"numberOfMissAppointment": 0
	}
}*/