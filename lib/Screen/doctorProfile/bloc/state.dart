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
  SuccessProfileStates(this.profileDoctor, this.error);
}
