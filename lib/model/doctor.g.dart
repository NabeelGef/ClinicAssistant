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

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctors': instance.doctors,
    };

Doctors _$DoctorsFromJson(Map<String, dynamic> json) => Doctors(
      id: json['id'] as String?,
      profilePicture: json['profilePicture'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      evaluate: json['evaluate'] as int?,
      checkupPrice: json['checkupPrice'] as int?,
      specialtyName: json['specialtyName'] as String?,
      active: json['active'] as bool?,
      description: json['description'] as String?,
      subSpecialtyName: json['subSpecialtyName'] as String?,
      numberOfPeopleWhoVoted: json['numberOfPeopleWhoVoted'] as int?,
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => Clinics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorsToJson(Doctors instance) => <String, dynamic>{
      'id': instance.id,
      'profilePicture': instance.profilePicture,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'evaluate': instance.evaluate,
      'checkupPrice': instance.checkupPrice,
      'specialtyName': instance.specialtyName,
      'active': instance.active,
      'description': instance.description,
      'subSpecialtyName': instance.subSpecialtyName,
      'numberOfPeopleWhoVoted': instance.numberOfPeopleWhoVoted,
      'clinics': instance.clinics,
    };
