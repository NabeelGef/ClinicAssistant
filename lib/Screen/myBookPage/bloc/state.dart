// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/current_appointment.dart';

class MyBookState {
  CurrentMyBookState currentMyBookState;
  PreviousMyBookState previousMyBookState;
  MyBookState({
    required this.currentMyBookState,
    required this.previousMyBookState,
  });
}

class CurrentMyBookState {
  String error;
  CurrentAppointment? currentAppointment;
  CurrentMyBookState({
    required this.error,
    this.currentAppointment,
  });
}

class PreviousMyBookState {
  String error;
  CurrentAppointment? currentAppointment;
  PreviousMyBookState({
    required this.error,
    this.currentAppointment,
  });
}
