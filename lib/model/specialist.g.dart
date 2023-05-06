// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialists _$SpecialistsFromJson(Map<String, dynamic> json) => Specialists(
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecialistsToJson(Specialists instance) =>
    <String, dynamic>{
      'specialties': instance.specialties,
    };

Specialist _$SpecialistFromJson(Map<String, dynamic> json) => Specialist(
      specialtyId: json['specialtyId'] as String?,
      specialtyName: json['specialtyName'] as String?,
      subSpecialties: (json['subSpecialties'] as List<dynamic>?)
          ?.map((e) => SubSpecialties.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecialistToJson(Specialist instance) =>
    <String, dynamic>{
      'specialtyId': instance.specialtyId,
      'specialtyName': instance.specialtyName,
      'subSpecialties': instance.subSpecialties,
    };

SubSpecialties _$SubSpecialtiesFromJson(Map<String, dynamic> json) =>
    SubSpecialties(
      subSpecialtyId: json['subSpecialtyId'] as String?,
      subSpecialtyName: json['subSpecialtyName'] as String?,
    );

Map<String, dynamic> _$SubSpecialtiesToJson(SubSpecialties instance) =>
    <String, dynamic>{
      'subSpecialtyId': instance.subSpecialtyId,
      'subSpecialtyName': instance.subSpecialtyName,
    };
