// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialists _$SpecialistsFromJson(Map<String, dynamic> json) => Specialists(
      specialist: (json['specialist'] as List<dynamic>?)
          ?.map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecialistsToJson(Specialists instance) =>
    <String, dynamic>{
      'specialist': instance.specialist,
    };

Specialist _$SpecialistFromJson(Map<String, dynamic> json) => Specialist(
      id: json['id'] as String?,
      specialtyName: json['specialtyName'] as String?,
      subspecialties: (json['subspecialties'] as List<dynamic>?)
          ?.map((e) => Subspecialties.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecialistToJson(Specialist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specialtyName': instance.specialtyName,
      'subspecialties': instance.subspecialties,
    };

Subspecialties _$SubspecialtiesFromJson(Map<String, dynamic> json) =>
    Subspecialties(
      subSpecialtyName: json['subSpecialtyName'] as String?,
    );

Map<String, dynamic> _$SubspecialtiesToJson(Subspecialties instance) =>
    <String, dynamic>{
      'subSpecialtyName': instance.subSpecialtyName,
    };
