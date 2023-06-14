// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileDoctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDoctor _$ProfileDoctorFromJson(Map<String, dynamic> json) =>
    ProfileDoctor(
      doctorProfile: json['doctorProfile'] == null
          ? null
          : DoctorProfile.fromJson(
              json['doctorProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileDoctorToJson(ProfileDoctor instance) =>
    <String, dynamic>{
      'doctorProfile': instance.doctorProfile,
    };

DoctorProfile _$DoctorProfileFromJson(Map<String, dynamic> json) =>
    DoctorProfile(
      doctor: json['doctor'] == null
          ? null
          : Doctors.fromJson(json['doctor'] as Map<String, dynamic>),
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => ClinicElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList(),
      insurances: (json['insurances'] as List<dynamic>?)
          ?.map((e) => Insurances.fromJson(e as Map<String, dynamic>))
          .toList(),
      clinicWorkingNow: json['clinicWorkingNow'] == null
          ? null
          : ClinicWorkingNow.fromJson(
              json['clinicWorkingNow'] as Map<String, dynamic>),
      canEvaluate: json['canEvaluate'] as bool?,
      tokenIsCorrect: json['tokenIsCorrect'] as bool?,
    );

Map<String, dynamic> _$DoctorProfileToJson(DoctorProfile instance) =>
    <String, dynamic>{
      'doctor': instance.doctor,
      'clinics': instance.clinics,
      'specialties': instance.specialties,
      'insurances': instance.insurances,
      'canEvaluate': instance.canEvaluate,
      'clinicWorkingNow': instance.clinicWorkingNow,
      'tokenIsCorrect': instance.tokenIsCorrect,
    };

ClinicWorkingNow _$ClinicWorkingNowFromJson(Map<String, dynamic> json) =>
    ClinicWorkingNow(
      clinicId: json['clinicId'] as String?,
      clinicName: json['clinicName'] as String?,
    );

Map<String, dynamic> _$ClinicWorkingNowToJson(ClinicWorkingNow instance) =>
    <String, dynamic>{
      'clinicId': instance.clinicId,
      'clinicName': instance.clinicName,
    };
