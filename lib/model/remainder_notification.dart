import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remainder_notification.g.dart';

@JsonSerializable()
class RemainderNotification {
  RemainderNotification({
    this.patientReminders,
  });

  final List<PatientReminder>? patientReminders;

  factory RemainderNotification.fromJson(Map<String, dynamic> json) =>
      _$RemainderNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$RemainderNotificationToJson(this);
}

@JsonSerializable()
class PatientReminder {
  PatientReminder({
    this.createdAt,
    this.doctor,
    this.clinic,
    this.appointment,
  });

  final String? createdAt;
  final Doctors? doctor;
  final ClinicElement? clinic;
  final Appointment? appointment;

  factory PatientReminder.fromJson(Map<String, dynamic> json) =>
      _$PatientReminderFromJson(json);

  Map<String, dynamic> toJson() => _$PatientReminderToJson(this);
}
