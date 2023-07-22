// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cancle _$CancleFromJson(Map<String, dynamic> json) => Cancle(
      cancelState: json['cancelState'] == null
          ? null
          : CancelState.fromJson(json['cancelState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CancleToJson(Cancle instance) => <String, dynamic>{
      'cancelState': instance.cancelState,
    };

CancelState _$CancelStateFromJson(Map<String, dynamic> json) => CancelState(
      canCancel: json['canCancel'] as bool?,
      numberOfMissAppointment: json['numberOfMissAppointment'] as int?,
    );

Map<String, dynamic> _$CancelStateToJson(CancelState instance) =>
    <String, dynamic>{
      'canCancel': instance.canCancel,
      'numberOfMissAppointment': instance.numberOfMissAppointment,
    };
