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
      workTime: (json['workTime'] as List<dynamic>?)
          ?.map((e) => WorkTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorClinicDetailsToJson(
        DoctorClinicDetails instance) =>
    <String, dynamic>{
      'doctorClinics': instance.doctorClinics,
      'doctor': instance.doctor,
      'clinic': instance.clinic,
      'isWorkingNow': instance.isWorkingNow,
      'workTime': instance.workTime,
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

WorkTime _$WorkTimeFromJson(Map<String, dynamic> json) => WorkTime(
      workTimeId: json['workTimeId'] as String?,
      startingTime: json['startingTime'] as String?,
      finishingTime: json['finishingTime'] as String?,
      day: json['day'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$WorkTimeToJson(WorkTime instance) => <String, dynamic>{
      'workTimeId': instance.workTimeId,
      'startingTime': instance.startingTime,
      'finishingTime': instance.finishingTime,
      'day': instance.day,
      'date': instance.date?.toIso8601String(),
    };
