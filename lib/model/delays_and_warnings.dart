import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delays_and_warnings.g.dart';

@JsonSerializable()
class DelaysAndWarningsNotification {
  DelaysAndWarningsNotification({
    this.patientDelays,
  });

  final List<PatientDelay>? patientDelays;

  factory DelaysAndWarningsNotification.fromJson(Map<String, dynamic> json) =>
      _$DelaysAndWarningsNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$DelaysAndWarningsNotificationToJson(this);
}

@JsonSerializable()
class PatientDelay {
  PatientDelay({
    this.message,
    this.createdAt,
    this.doctor,
    this.clinic,
  });

  final String? message;
  final String? createdAt;
  final Doctors? doctor;
  final ClinicElement? clinic;

  factory PatientDelay.fromJson(Map<String, dynamic> json) =>
      _$PatientDelayFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDelayToJson(this);
}
