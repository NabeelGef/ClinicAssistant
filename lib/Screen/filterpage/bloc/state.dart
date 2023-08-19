// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/insurance.dart';
import 'package:clinicassistant/model/specialist.dart';

class FilteringState {
  SuccessFilterDoctorState successFilterDoctorState;
  FilteringState({
    required this.successFilterDoctorState,
  });
}

class SuccessFilterDoctorState {
  final Doctor? doctor;
  final String error;
  SuccessFilterDoctorState({
    this.doctor,
    required this.error,
  });
}

class SuccessSpecialistsState {
  final Specialists? specialists;
  final String error;
  SuccessSpecialistsState({
    this.specialists,
    required this.error,
  });
}

class SuccessInsurancesState {
  final Insurance? insurance;
  final String error;
  SuccessInsurancesState({
    this.insurance,
    required this.error,
  });
}

class SpecialAndInsuranceState {
  SuccessSpecialistsState successSpecialistsState;
  SuccessInsurancesState successInsurancesState;
  List<String> gender = ["ذكر", "انثى"];
  SpecialAndInsuranceState({
    required this.successSpecialistsState,
    required this.successInsurancesState,
  });
}
