// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/area.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/governorate.dart';
import 'package:fl_location/fl_location.dart';

class SearchByLocationState {
  GetGovernorateState getGovernorateState;
  GetAreaState getAreaState;
  GetClinicState getClinicState;
  bool? isClickArea;
  Location? Mylocation;
  SearchByLocationState(this.getGovernorateState, this.getAreaState,
      this.getClinicState, this.isClickArea, this.Mylocation);
}

class GetGovernorateState {
  AllGovernorate? allGovernorate;
  String? error;
  Governorate? dropdowngovernate;
  GetGovernorateState({
    this.allGovernorate,
    this.error,
    this.dropdowngovernate,
  });
}

class GetAreaState {
  AllArea? allArea;
  String? error;
  Area? dropdownarea;
  GetAreaState({
    this.allArea,
    this.error,
    this.dropdownarea,
  });
}

class GetClinicState {
  Clinic? clinic;
  String? error;
  GetClinicState({
    this.clinic,
    this.error,
  });
}
