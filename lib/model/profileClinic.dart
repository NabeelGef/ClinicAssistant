import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profileClinic.g.dart';

@JsonSerializable()
class ProfileClinic {
  ProfileClinic({
    this.clinic,
    this.doctors,
    this.doctorWorkingNow,
  });

  final ClinicElement? clinic;
  final List<Doctors>? doctors;
  final DoctorWorkingNow? doctorWorkingNow;

  factory ProfileClinic.fromJson(Map<String, dynamic> json) =>
      _$ProfileClinicFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileClinicToJson(this);
}

@JsonSerializable()
class DoctorWorkingNow {
  String doctorId;
  String firstname;
  String lastname;

  DoctorWorkingNow(
      {required this.doctorId,
      required this.firstname,
      required this.lastname});
  factory DoctorWorkingNow.fromJson(Map<String, dynamic> json) =>
      _$DoctorWorkingNowFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorWorkingNowToJson(this);
}

/*
{
	"clinic": {
		"clinicId": "2",
		"clinicName": "عيادة الشّفاء",
		"Latitude": "35.29683021456003",
		"Longitude": "37.29683021456003",
		"createdAt": "2023-05-30T09:52:23.000Z",
		"phonenumber": "3225878",
		"numDoctors": 0,
		"specialty": {
			"specialtyId": "2",
			"specialtyName": "قلبية"
		}
	},
	"doctors": [
		{
			"doctorId": "14",
			"firstname": "ماهر",
			"lastname": "المحمد",
			"evaluate": "3.00"
		}
	],
	"doctorWorkingNow": null
}*/