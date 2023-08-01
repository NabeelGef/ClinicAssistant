// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/insurance.dart';
import 'package:clinicassistant/model/specialist.dart';

class FilterEvent {
  FilterEvent();
}

class LoadingDoctorsFiltirng extends FilterEvent {
  int? subSpecialtyId;
  String? gender;
  int? insuranceId;
  LoadingDoctorsFiltirng({
    this.subSpecialtyId,
    this.gender,
    this.insuranceId,
  });
}

class LoadingSpecialistsFiltring extends FilterEvent {}

class LoadingInsurancesFiltring extends FilterEvent {}

class ChooseSpecialist extends FilterEvent {
  final int index;
  final Specialist specialist;
  ChooseSpecialist({
    required this.index,
    required this.specialist,
  });
}

class ChooseSubSpecialist extends FilterEvent {
  final int index;
  final SubSpecialties sub;
  ChooseSubSpecialist({
    required this.index,
    required this.sub,
  });
}

class ChooseInsurance extends FilterEvent {
  final Insurances insurance;
  ChooseInsurance({
    required this.insurance,
  });
}

class ChooseGender extends FilterEvent {
  final String gender;
  ChooseGender({
    required this.gender,
  });
}

class Reset extends FilterEvent {}
