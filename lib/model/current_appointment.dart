import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_appointment.g.dart';

@JsonSerializable()
class CurrentAppointment {
  CurrentAppointment({
    this.appointments,
  });

  final List<Appointment>? appointments;

  factory CurrentAppointment.fromJson(Map<String, dynamic> json) =>
      _$CurrentAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAppointmentToJson(this);
}

@JsonSerializable()
class Appointment {
  Appointment(
      {this.id,
      this.startingTime,
      this.finishingTime,
      this.workTime,
      this.missedAppointment});

  final String? id;
  final String? startingTime;
  final String? finishingTime;
  final bool? missedAppointment;
  final WorkTimeData? workTime;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

@JsonSerializable()
class WorkTimeData {
  WorkTimeData({
    this.date,
    this.doctor,
    this.clinic,
  });

  final String? date;
  final Doctors? doctor;
  final ClinicElement? clinic;

  factory WorkTimeData.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeDataToJson(this);
}


/*
{
	"appointments": [
		{
			"id": "79",
			"startingTime": "20:00:00",
			"finishingTime": "20:30:00",
			"workTime": {
				"date": "2023-07-09",
				"doctor": {
					"doctorId": "2",
					"profilePicture": null,
					"firstname": "yamen mahmoud",
					"lastname": "arksose"
				},
				"clinic": {
					"clinicId": "1",
					"clinicName": "yamen new",
					"specialty": {
						"specialtyName": "عين1ية"
					}
				}
			}
		}
	]
}*/