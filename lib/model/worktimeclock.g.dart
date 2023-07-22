// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worktimeclock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTimeClock _$WorkTimeClockFromJson(Map<String, dynamic> json) =>
    WorkTimeClock(
      appointment: (json['appointment'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkTimeClockToJson(WorkTimeClock instance) =>
    <String, dynamic>{
      'appointment': instance.appointment,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as String?,
      startingTime: json['startingTime'] as String?,
      finishingTime: json['finishingTime'] as String?,
      isBooked: json['isBooked'] as bool?,
      workTime: json['workTime'] == null
          ? null
          : WorkTimeElement.fromJson(json['workTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startingTime': instance.startingTime,
      'finishingTime': instance.finishingTime,
      'isBooked': instance.isBooked,
      'workTime': instance.workTime,
    };
