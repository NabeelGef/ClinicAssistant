// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clinic _$ClinicFromJson(Map<String, dynamic> json) => Clinic(
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => Clinics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'clinics': instance.clinics,
    };

Clinics _$ClinicsFromJson(Map<String, dynamic> json) {
  try {
    return Clinics(
      id: json['id'] as String?,
      clinicName: json['clinicName'] as String?,
      location: json['location'] as String?,
      numDoctors: json['numDoctors'] as String?,
    );
  }
  catch(e){
    print("Data : $e");
    return Clinics(
      id: json['id'] as String?,
      clinicName: json['clinicName'] as String?,
      location: json['location'] as String?,
      numDoctors: json['numDoctors'] as String?,
    );
  }
}
Map<String, dynamic> _$ClinicsToJson(Clinics instance) => <String, dynamic>{
      'id': instance.id,
      'clinicName': instance.clinicName,
      'location': instance.location,
      'numDoctors': instance.numDoctors,
    };
