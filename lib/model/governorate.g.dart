// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllGovernorate _$AllGovernorateFromJson(Map<String, dynamic> json) =>
    AllGovernorate(
      governorates: (json['governorates'] as List<dynamic>?)
          ?.map((e) => Governorate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllGovernorateToJson(AllGovernorate instance) =>
    <String, dynamic>{
      'governorates': instance.governorates,
    };
