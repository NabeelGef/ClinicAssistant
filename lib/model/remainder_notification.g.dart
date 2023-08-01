// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remainder_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemainderNotification _$RemainderNotificationFromJson(
        Map<String, dynamic> json) =>
    RemainderNotification(
      patientReminders: (json['patientReminders'] as List<dynamic>?)
          ?.map((e) => PatientReminder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemainderNotificationToJson(
        RemainderNotification instance) =>
    <String, dynamic>{
      'patientReminders': instance.patientReminders,
    };

PatientReminder _$PatientReminderFromJson(Map<String, dynamic> json) =>
    PatientReminder(
      createdAt: json['createdAt'] as String?,
      doctor: json['doctor'] == null
          ? null
          : Doctors.fromJson(json['doctor'] as Map<String, dynamic>),
      clinic: json['clinic'] == null
          ? null
          : ClinicElement.fromJson(json['clinic'] as Map<String, dynamic>),
      appointment: json['appointment'] == null
          ? null
          : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientReminderToJson(PatientReminder instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'doctor': instance.doctor,
      'clinic': instance.clinic,
      'appointment': instance.appointment,
    };
