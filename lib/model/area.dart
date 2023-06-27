import 'package:json_annotation/json_annotation.dart';

import 'clinic.dart';

part 'area.g.dart';

@JsonSerializable()
class AllArea {
  AllArea({
    this.areas,
  });

  @JsonKey(name: 'Areas')
  final List<Area>? areas;

  factory AllArea.fromJson(Map<String, dynamic> json) =>
      _$AllAreaFromJson(json);

  Map<String, dynamic> toJson() => _$AllAreaToJson(this);
}



/*
{
	"Areas": [
		{
			"areaId": "64",
			"name": "طرطوس"
		},
		{
			"areaId": "65",
			"name": "صافيتا"
		},
		{
			"areaId": "66",
			"name": "دريكيش"
		},
		{
			"areaId": "67",
			"name": "الشيخ بدر"
		},
		{
			"areaId": "68",
			"name": "بانياس"
		}
	]
}*/