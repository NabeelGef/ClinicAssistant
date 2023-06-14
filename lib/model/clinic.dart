import 'package:clinicassistant/model/specialist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clinic.g.dart';

@JsonSerializable()
class Clinic {
  Clinic({
     this.clinics,
  });

  final List<ClinicElement>? clinics;

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicToJson(this);

}

@JsonSerializable()
class ClinicElement {
  ClinicElement({
     this.clinicId,
     this.clinicName,
     this.numDoctors,
     this.phonenumber,
     this.area,
     this.specialty,
     this.latitude,
     this.longitude,

  });

  final String? clinicId;
  final String? clinicName;
  final int? numDoctors;
  final String? phonenumber;
  final Area? area;
  @JsonKey(name: 'Latitude')
  final String? latitude;

  @JsonKey(name: 'Longitude')
  final String? longitude;
  final Specialist? specialty;


  factory ClinicElement.fromJson(Map<String, dynamic> json) => _$ClinicElementFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicElementToJson(this);

}

@JsonSerializable()
class Area {
  Area({
     this.areaId,
     this.name,
     this.governorate,
  });
  final Governorate? governorate;
  final String? areaId;
  final String? name;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);

}

@JsonSerializable()
class Governorate {
  Governorate({
     this.governorateId,
     this.name,
  });

  final String? governorateId;
  final String? name;

  factory Governorate.fromJson(Map<String, dynamic> json) => _$GovernorateFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateToJson(this);

}

/*
{
	"clinics": [
		{
			"clinicId": "1",
			"clinicName": "عيادة السلام",
			"createdAt": "2023-05-24T11:16:57.000Z",
			"numDoctors": 0,
			"area": {
				"areaId": "48",
				"name": "المهاجرين"
			}
		},
		{
			"clinicId": "2",
			"clinicName": "عيادة الدكتور محمد الحمدي",
			"createdAt": "2023-05-24T11:16:57.000Z",
			"numDoctors": 0,
			"area": {
				"areaId": "54",
				"name": "الزبداني"
			}
		},
		{
			"clinicId": "3",
			"clinicName": "عيادة الدكتور أحمد الحبيب",
			"createdAt": "2023-05-24T11:16:57.000Z",
			"numDoctors": 0,
			"area": {
				"areaId": "19",
				"name": "منبج"
			}
		},
		{
			"clinicId": "4",
			"clinicName": "عيادة العاصمة",
			"createdAt": "2023-05-24T11:16:57.000Z",
			"numDoctors": 0,
			"area": {
				"areaId": "34",
				"name": "دمشق القديمة"
			}
		}
	]
}*/