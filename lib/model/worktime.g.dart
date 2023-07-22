// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worktime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) => WorkTime(
      doctorClinicWorkTime: json['doctorClinicWorkTime'] == null
          ? null
          : DoctorClinicWorkTime.fromJson(
              json['doctorClinicWorkTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'doctorClinicWorkTime': instance.doctorClinicWorkTime,
    };

DoctorClinicWorkTime _$DoctorClinicWorkTimeFromJson(
        Map<String, dynamic> json) =>
    DoctorClinicWorkTime(
      workTimes: (json['workTimes'] as List<dynamic>?)
          ?.map((e) => WorkTimeElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      startingDate: json['startingDate'] == null
          ? null
          : (json['startingDate'] as String),
      finishingDate: json['finishingDate'] == null
          ? null
          : (json['finishingDate'] as String),
    );

Map<String, dynamic> _$DoctorClinicWorkTimeToJson(
        DoctorClinicWorkTime instance) =>
    <String, dynamic>{
      'workTimes': instance.workTimes,
      'startingDate': instance.startingDate,
      'finishingDate': instance.finishingDate,
    };

WorkTimeElement _$WorkTimeElementFromJson(Map<String, dynamic> json) =>
    WorkTimeElement(
      workTimeId: json['workTimeId'] as String?,
      startingTime: json['startingTime'] as String?,
      finishingTime: json['finishingTime'] as String?,
      day: json['day'] as String?,
      date: json['date'] == null ? null : json['date'] as String,
      haveAppointments: json['haveAppointments'] as bool?,
    );

Map<String, dynamic> _$WorkTimeElementToJson(WorkTimeElement instance) =>
    <String, dynamic>{
      'workTimeId': instance.workTimeId,
      'startingTime': instance.startingTime,
      'finishingTime': instance.finishingTime,
      'day': instance.day,
      'date': instance.date,
      'haveAppointments': instance.haveAppointments,
    };
