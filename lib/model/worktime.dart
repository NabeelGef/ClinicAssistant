import 'package:json_annotation/json_annotation.dart';

part 'worktime.g.dart';

@JsonSerializable()
class WorkTime {
  WorkTime({
    this.doctorClinicWorkTime,
  });

  final DoctorClinicWorkTime? doctorClinicWorkTime;

  factory WorkTime.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeToJson(this);
}

@JsonSerializable()
class DoctorClinicWorkTime {
  DoctorClinicWorkTime({
    this.workTimes,
    this.startingDate,
    this.finishingDate,
  });

  final List<WorkTimeElement>? workTimes;
  final DateTime? startingDate;
  final DateTime? finishingDate;

  factory DoctorClinicWorkTime.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicWorkTimeFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorClinicWorkTimeToJson(this);
}

@JsonSerializable()
class WorkTimeElement {
  WorkTimeElement({
    this.workTimeId,
    this.startingTime,
    this.finishingTime,
    this.day,
    this.date,
    this.haveAppointments,
  });

  final String? workTimeId;
  final String? startingTime;
  final String? finishingTime;
  final String? day;
  final DateTime? date;
  final bool? haveAppointments;

  factory WorkTimeElement.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeElementFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeElementToJson(this);
}

/*
{
	"doctorClinicWorkTime": {
		"workTimes": [
		{
				"workTimeId": "28",
				"startingTime": "12:00:00",
				"finishingTime": "18:00:00",
				"day": "الجمعة",
				"date": "2023-06-30",
				"haveAppointments": true
			}
		],
		"startingDate": "2023-06-17",
		"finishingDate": "2023-06-30"
	}
}*/