import 'package:json_annotation/json_annotation.dart';
part 'specialist.g.dart';


/////////////////////////////////////////////////////
//Model of Specialists ans SubSpecialists and Doctors
/////////////////////////////////////////////////////


@JsonSerializable()
class Specialists {
  List<Specialist>? specialist;

  Specialists({this.specialist});

  factory Specialists.fromJson(Map<String, dynamic> json) {
    return _$SpecialistsFromJson(json);
  }

  Map<String, dynamic> toJson() {

    return _$SpecialistsToJson(this);
  }
}
@JsonSerializable()
class Specialist {
  String? id;
  String? specialtyName;
  List<Subspecialties>? subspecialties;

  Specialist({this.id, this.specialtyName, this.subspecialties});

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return _$SpecialistFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SpecialistToJson(this);
  }
}
@JsonSerializable()
class Subspecialties {

  String? subSpecialtyName;

  Subspecialties({this.subSpecialtyName});

  factory Subspecialties.fromJson(Map<String, dynamic> json) {
     return _$SubspecialtiesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubspecialtiesToJson(this);
  }
}
