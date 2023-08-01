// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personl_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      patient: json['patient'] == null
          ? null
          : PatientElement.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'patient': instance.patient,
    };

PatientElement _$PatientElementFromJson(Map<String, dynamic> json) =>
    PatientElement(
      patientId: json['patientId'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      profilePicture: json['profilePicture'] as String?,
      birthDate: json['birthDate'] as String?,
      numberOfMissAppointment: json['numberOfMissAppointment'] as int?,
    );

Map<String, dynamic> _$PatientElementToJson(PatientElement instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'profilePicture': instance.profilePicture,
      'birthDate': instance.birthDate,
      'numberOfMissAppointment': instance.numberOfMissAppointment,
    };
