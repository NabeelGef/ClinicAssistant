// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clinic _$ClinicFromJson(Map<String, dynamic> json) => Clinic(
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => ClinicElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'clinics': instance.clinics,
    };

ClinicElement _$ClinicElementFromJson(Map<String, dynamic> json) =>
    ClinicElement(
      clinicId: json['clinicId'] as String?,
      clinicName: json['clinicName'] as String?,
      numDoctors: json['numDoctors'] as int?,
      phonenumber: json['phonenumber'] as String?,
      area: json['area'] == null
          ? null
          : Area.fromJson(json['area'] as Map<String, dynamic>),
      specialty: json['specialty'] == null
          ? null
          : Specialist.fromJson(json['specialty'] as Map<String, dynamic>),
      latitude: json['Latitude'] as String?,
      longitude: json['Longitude'] as String?,
    );

Map<String, dynamic> _$ClinicElementToJson(ClinicElement instance) =>
    <String, dynamic>{
      'clinicId': instance.clinicId,
      'clinicName': instance.clinicName,
      'numDoctors': instance.numDoctors,
      'phonenumber': instance.phonenumber,
      'area': instance.area,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'specialty': instance.specialty,
    };

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      areaId: json['areaId'] as String?,
      name: json['name'] as String?,
      governorate: json['governorate'] == null
          ? null
          : Governorate.fromJson(json['governorate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'governorate': instance.governorate,
      'areaId': instance.areaId,
      'name': instance.name,
    };

Governorate _$GovernorateFromJson(Map<String, dynamic> json) => Governorate(
      governorateId: json['governorateId'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GovernorateToJson(Governorate instance) =>
    <String, dynamic>{
      'governorateId': instance.governorateId,
      'name': instance.name,
    };
