// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/clinic.dart';

class SearchLocationEvent {
  SearchLocationEvent();
}

class GetGovernorateEvent extends SearchLocationEvent {}

class ChangeDropDownGovernorateEvent extends SearchLocationEvent {
  Governorate? dropdown;
  ChangeDropDownGovernorateEvent({
    this.dropdown,
  });
}

class ChangeDropDownAreaEvent extends SearchLocationEvent {
  Area? dropdown;
  ChangeDropDownAreaEvent({
    this.dropdown,
  });
}

class SearchByLocationEvent extends SearchLocationEvent {
  String areaId;
  String specialId;
  SearchByLocationEvent({
    required this.areaId,
    required this.specialId,
  });
}

class AddMyLocationEvent extends SearchLocationEvent {}

class SearchByMYLocationEvent extends SearchLocationEvent {
  double Latitude;
  double Longitude;
  String specialId;
  SearchByMYLocationEvent({
    required this.Latitude,
    required this.Longitude,
    required this.specialId,
  });
}
