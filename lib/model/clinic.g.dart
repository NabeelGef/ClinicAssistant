// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clinic _$ClinicFromJson(Map<String, dynamic> json) => Clinic(
      clinics: (json['clinics'] as List<dynamic>?)
          !.map((e) => ClinicElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'clinics': instance.clinics,
    };

ClinicElement _$ClinicElementFromJson(Map<String, dynamic> json) =>
    ClinicElement(
      clinicId: json['clinicId'] as String?,
      clinicName: json['clinicName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      numDoctors: json['numDoctors'] as int?,
      area: json['area'] == null
          ? null
          : Area.fromJson(json['area'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClinicElementToJson(ClinicElement instance) =>
    <String, dynamic>{
      'clinicId': instance.clinicId,
      'clinicName': instance.clinicName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'numDoctors': instance.numDoctors,
      'area': instance.area,
    };

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      areaId: json['areaId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'areaId': instance.areaId,
      'name': instance.name,
    };
