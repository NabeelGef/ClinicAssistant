// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Insurance _$InsuranceFromJson(Map<String, dynamic> json) => Insurance(
      insurances: (json['insurances'] as List<dynamic>?)
          ?.map((e) => Insurances.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InsuranceToJson(Insurance instance) => <String, dynamic>{
      'insurances': instance.insurances,
    };

Insurances _$InsurancesFromJson(Map<String, dynamic> json) => Insurances(
      insuranceId: json['insuranceId'] as String?,
      companyName: json['companyName'] as String?,
    );

Map<String, dynamic> _$InsurancesToJson(Insurances instance) =>
    <String, dynamic>{
      'insuranceId': instance.insuranceId,
      'companyName': instance.companyName,
    };
