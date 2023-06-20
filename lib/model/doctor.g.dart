// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctor: (json['doctor'] as List<dynamic>)
          .map((e) => Doctors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctor': instance.doctor,
    };

Doctors _$DoctorsFromJson(Map<String, dynamic> json) => Doctors(
      doctorId: json['doctorId'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phonenumberForAdmin: json['phonenumberForAdmin'] as String?,
      active: json['active'] as bool?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      profilePicture: json['profilePicture'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      evaluate: json['evaluate'] as String?,
      numberOfPeopleWhoVoted: json['numberOfPeopleWhoVoted'] as int?,
      phonenumber: json['phonenumber'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorsToJson(Doctors instance) => <String, dynamic>{
      'doctorId': instance.doctorId,
      'description': instance.description,
      'email': instance.email,
      'phonenumberForAdmin': instance.phonenumberForAdmin,
      'active': instance.active,
      'password': instance.password,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'evaluate': instance.evaluate,
      'numberOfPeopleWhoVoted': instance.numberOfPeopleWhoVoted,
      'phonenumber': instance.phonenumber,
      'createdAt': instance.createdAt?.toIso8601String(),
      'specialties': instance.specialties,
    };
