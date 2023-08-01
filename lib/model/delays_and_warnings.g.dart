// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delays_and_warnings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DelaysAndWarningsNotification _$DelaysAndWarningsNotificationFromJson(
        Map<String, dynamic> json) =>
    DelaysAndWarningsNotification(
      patientDelays: (json['patientDelays'] as List<dynamic>?)
          ?.map((e) => PatientDelay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DelaysAndWarningsNotificationToJson(
        DelaysAndWarningsNotification instance) =>
    <String, dynamic>{
      'patientDelays': instance.patientDelays,
    };

PatientDelay _$PatientDelayFromJson(Map<String, dynamic> json) => PatientDelay(
      message: json['message'] as String?,
      createdAt: json['createdAt'] as String?,
      doctor: json['doctor'] == null
          ? null
          : Doctors.fromJson(json['doctor'] as Map<String, dynamic>),
      clinic: json['clinic'] == null
          ? null
          : ClinicElement.fromJson(json['clinic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientDelayToJson(PatientDelay instance) =>
    <String, dynamic>{
      'message': instance.message,
      'createdAt': instance.createdAt,
      'doctor': instance.doctor,
      'clinic': instance.clinic,
    };
