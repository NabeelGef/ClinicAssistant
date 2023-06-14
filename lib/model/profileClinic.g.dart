// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileClinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileClinic _$ProfileClinicFromJson(Map<String, dynamic> json) =>
    ProfileClinic(
      clinic: json['clinic'] == null
          ? null
          : ClinicElement.fromJson(json['clinic'] as Map<String, dynamic>),
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => Doctors.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctorWorkingNow: json['doctorWorkingNow'],
    );

Map<String, dynamic> _$ProfileClinicToJson(ProfileClinic instance) =>
    <String, dynamic>{
      'clinic': instance.clinic,
      'doctors': instance.doctors,
      'doctorWorkingNow': instance.doctorWorkingNow,
    };
