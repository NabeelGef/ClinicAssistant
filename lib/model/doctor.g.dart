// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => Doctors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Doctors _$DoctorsFromJson(Map<String, dynamic> json) => Doctors(
      id: json['id'] as String?,
      profilePicture: json['profilePicture'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      evaluate: json['evaluate'] as int?,
      specialtyName: json['specialtyName'] as String?,
      subSpecialtyName: json['subSpecialtyName'] as String?,
    );
