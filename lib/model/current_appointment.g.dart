// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAppointment _$CurrentAppointmentFromJson(Map<String, dynamic> json) =>
    CurrentAppointment(
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentAppointmentToJson(CurrentAppointment instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
    };

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as String?,
      startingTime: json['startingTime'] as String?,
      finishingTime: json['finishingTime'] as String?,
      workTime: json['workTime'] == null
          ? null
          : WorkTimeData.fromJson(json['workTime'] as Map<String, dynamic>),
      missedAppointment: json['missedAppointment'] as bool?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startingTime': instance.startingTime,
      'finishingTime': instance.finishingTime,
      'missedAppointment': instance.missedAppointment,
      'workTime': instance.workTime,
    };

WorkTimeData _$WorkTimeDataFromJson(Map<String, dynamic> json) => WorkTimeData(
      date: json['date'] as String?,
      doctor: json['doctor'] == null
          ? null
          : Doctors.fromJson(json['doctor'] as Map<String, dynamic>),
      clinic: json['clinic'] == null
          ? null
          : ClinicElement.fromJson(json['clinic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkTimeDataToJson(WorkTimeData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'doctor': instance.doctor,
      'clinic': instance.clinic,
    };
