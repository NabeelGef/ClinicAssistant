import 'package:clinicassistant/model/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'clinic.dart';

part 'doctorClinicBook.g.dart';

@JsonSerializable()
class DoctorClinicBook {
  DoctorClinicBook({
    this.doctorClinicDetails,
  });

  final DoctorClinicDetails? doctorClinicDetails;

  factory DoctorClinicBook.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicBookFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorClinicBookToJson(this);
}

@JsonSerializable()
class DoctorClinicDetails {
  DoctorClinicDetails({
    this.doctorClinics,
    this.doctor,
    this.clinic,
    this.isWorkingNow,
    this.workTime,
  });
  final DoctorClinics? doctorClinics;
  final Doctors? doctor;
  final ClinicElement? clinic;
  final bool? isWorkingNow;
  final List<WorkTime>? workTime;

  factory DoctorClinicDetails.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorClinicDetailsToJson(this);
}

@JsonSerializable()
class DoctorClinics {
  DoctorClinics({
    this.id,
    this.appointmentDuring,
    this.checkupPrice,
  });
  final String? id;
  final int? appointmentDuring;
  final int? checkupPrice;

  factory DoctorClinics.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicsFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorClinicsToJson(this);
}

@JsonSerializable()
class WorkTime {
  WorkTime({
    this.workTimeId,
    this.startingTime,
    this.finishingTime,
    this.day,
    this.date,
  });

  final String? workTimeId;
  final String? startingTime;
  final String? finishingTime;
  final String? day;
  final DateTime? date;

  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);
}

/*
{
	"doctorClinicDetails": {
		"doctorClinics": {
			"id": "6",
			"appointmentDuring": 20,
			"checkupPrice": 35000
		},
		"doctor": {
			"firstname": "ماهر",
			"lastname": "المحمد"
		},
		"clinic": {
			"clinicId": "2",
			"clinicName": "عيادة الشّفاء",
			"phonenumber": "3225878",
			"specialty": {
				"specialtyId": "2",
				"specialtyName": "قلبية"
			},
			"area": {
				"areaId": "42",
				"name": "المزة",
				"governorate": {
					"governorateId": "7",
					"name": "دمشق"
				}
			}
		},
		"isWorkingNow": false,
		"workTime": [
			{
				"workTimeId": "9",
				"startingTime": "15:26:30",
				"finishingTime": "00:00:00",
				"day": "الثلاثاء",
				"date": "2023-06-13"
			},
			{
				"workTimeId": "10",
				"startingTime": "15:26:30",
				"finishingTime": "00:00:00",
				"day": "الأربعاء",
				"date": "2023-06-14"
			}
		]
	}
}*/