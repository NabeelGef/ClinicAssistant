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
      doctorWorkingNow: json['doctorWorkingNow'] == null
          ? null
          : DoctorWorkingNow.fromJson(
              json['doctorWorkingNow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileClinicToJson(ProfileClinic instance) =>
    <String, dynamic>{
      'clinic': instance.clinic,
      'doctors': instance.doctors,
      'doctorWorkingNow': instance.doctorWorkingNow,
    };

DoctorWorkingNow _$DoctorWorkingNowFromJson(Map<String, dynamic> json) =>
    DoctorWorkingNow(
      doctorId: json['doctorId'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );

Map<String, dynamic> _$DoctorWorkingNowToJson(DoctorWorkingNow instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
