// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/profileDoctor.dart';

abstract class DoctorProfileState {
  DoctorProfileState();
}

class DropDownStates extends DoctorProfileState {
  final String imageurl;
  DropDownStates(this.imageurl);
}

class CommunicationDropDownStates extends DoctorProfileState {
  final String imageurl;
  CommunicationDropDownStates(this.imageurl);
}

class SuccessProfileStates extends DoctorProfileState {
  final ProfileDoctor? profileDoctor;
  final String error;
  final EvaluateState? evaluateState;
  SuccessProfileStates(this.profileDoctor, this.error, this.evaluateState);
}

class EvaluateState {
  final String? evaluate;
  String? error;
  EvaluateState({
    this.evaluate,
    this.error,
  });
}
