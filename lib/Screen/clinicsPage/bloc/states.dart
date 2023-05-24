import 'package:clinicassistant/model/clinic.dart';

abstract class AllClinicStates{
  AllClinicStates();
}


class InitialState extends AllClinicStates{}

class SuccessAllClinicStates extends AllClinicStates{}

class ClinicsStates extends AllClinicStates{
  final Clinic? clinic;
  final String error;
  ClinicsStates(this.clinic, this.error);
}

