import 'package:json_annotation/json_annotation.dart';

part 'worktimeclock.g.dart';

@JsonSerializable()
class WorkTimeClock {
  WorkTimeClock({
    this.appointment,
  });

  final List<Appointment>? appointment;

  factory WorkTimeClock.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeClockFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTimeClockToJson(this);
}

@JsonSerializable()
class Appointment {
  Appointment({
    this.id,
    this.startingTime,
    this.finishingTime,
    this.isBooked,
  });

  final String? id;
  final String? startingTime;
  final String? finishingTime;
  final bool? isBooked;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

/*
{
	"appointment": [
		{
			"id": "253",
			"startingTime": "12:00:00",
			"finishingTime": "12:30:00",
			"isBooked": false
		},
		{
			"id": "254",
			"startingTime": "12:30:00",
			"finishingTime": "13:00:00",
			"isBooked": false
		},
		{
			"id": "255",
			"startingTime": "13:00:00",
			"finishingTime": "13:30:00",
			"isBooked": false
		},
		{
			"id": "256",
			"startingTime": "13:30:00",
			"finishingTime": "14:00:00",
			"isBooked": false
		},
		{
			"id": "257",
			"startingTime": "14:00:00",
			"finishingTime": "14:30:00",
			"isBooked": false
		},
		{
			"id": "258",
			"startingTime": "14:30:00",
			"finishingTime": "15:00:00",
			"isBooked": false
		},
		{
			"id": "259",
			"startingTime": "15:00:00",
			"finishingTime": "15:30:00",
			"isBooked": false
		},
		{
			"id": "260",
			"startingTime": "15:30:00",
			"finishingTime": "16:00:00",
			"isBooked": false
		},
		{
			"id": "261",
			"startingTime": "16:30:00",
			"finishingTime": "17:00:00",
			"isBooked": false
		},
		{
			"id": "262",
			"startingTime": "16:00:00",
			"finishingTime": "16:30:00",
			"isBooked": false
		},
		{
			"id": "263",
			"startingTime": "17:00:00",
			"finishingTime": "17:30:00",
			"isBooked": false
		},
		{
			"id": "264",
			"startingTime": "17:30:00",
			"finishingTime": "18:00:00",
			"isBooked": false
		}
	]
}*/