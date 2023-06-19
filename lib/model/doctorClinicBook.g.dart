// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctorClinicBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorClinicBook _$DoctorClinicBookFromJson(Map<String, dynamic> json) =>
    DoctorClinicBook(
      doctorClinicDetails: json['doctorClinicDetails'] == null
          ? null
          : DoctorClinicDetails.fromJson(
              json['doctorClinicDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorClinicBookToJson(DoctorClinicBook instance) =>
    <String, dynamic>{
      'doctorClinicDetails': instance.doctorClinicDetails,
    };

DoctorClinicDetails _$DoctorClinicDetailsFromJson(Map<String, dynamic> json) =>
    DoctorClinicDetails(
      doctorClinics: json['doctorClinics'] == null
          ? null
          : DoctorClinics.fromJson(
              json['doctorClinics'] as Map<String, dynamic>),
      doctor: json['doctor'] == null
          ? null
          : Doctors.fromJson(json['doctor'] as Map<String, dynamic>),
      clinic: json['clinic'] == null
          ? null
          : ClinicElement.fromJson(json['clinic'] as Map<String, dynamic>),
      isWorkingNow: json['isWorkingNow'] as bool?,
    );

Map<String, dynamic> _$DoctorClinicDetailsToJson(
        DoctorClinicDetails instance) =>
    <String, dynamic>{
      'doctorClinics': instance.doctorClinics,
      'doctor': instance.doctor,
      'clinic': instance.clinic,
      'isWorkingNow': instance.isWorkingNow,
    };

DoctorClinics _$DoctorClinicsFromJson(Map<String, dynamic> json) =>
    DoctorClinics(
      id: json['id'] as String?,
      appointmentDuring: json['appointmentDuring'] as int?,
      checkupPrice: json['checkupPrice'] as int?,
    );

Map<String, dynamic> _$DoctorClinicsToJson(DoctorClinics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentDuring': instance.appointmentDuring,
      'checkupPrice': instance.checkupPrice,
    };
