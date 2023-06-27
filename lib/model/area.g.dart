// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllArea _$AllAreaFromJson(Map<String, dynamic> json) => AllArea(
      areas: (json['Areas'] as List<dynamic>?)
          ?.map((e) => Area.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllAreaToJson(AllArea instance) => <String, dynamic>{
      'Areas': instance.areas,
    };
