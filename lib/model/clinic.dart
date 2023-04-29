import 'package:json_annotation/json_annotation.dart';

part 'clinic.g.dart';
//////////////////////////////////
//Make Model of Clinic and Clinics
//////////////////////////////////
@JsonSerializable()
class Clinic {
  List<Clinics>? clinics;

  Clinic({this.clinics});

 factory Clinic.fromJson(Map<String, dynamic> json) {
    return _$ClinicFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClinicToJson(this);
  }
}
@JsonSerializable()
class Clinics {
  String? id;
  String? clinicName;
  String? location;
  String? numDoctors;

  Clinics({this.id, this.clinicName, this.location, this.numDoctors});

 factory Clinics.fromJson(Map<String, dynamic> json) {
    return _$ClinicsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClinicsToJson(this);
  }
}
