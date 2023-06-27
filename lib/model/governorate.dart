import 'package:json_annotation/json_annotation.dart';

import 'clinic.dart';

part 'governorate.g.dart';

@JsonSerializable()
class AllGovernorate {
  AllGovernorate({
    this.governorates,
  });

  final List<Governorate>? governorates;

  factory AllGovernorate.fromJson(Map<String, dynamic> json) =>
      _$AllGovernorateFromJson(json);

  Map<String, dynamic> toJson() => _$AllGovernorateToJson(this);
}
/*
{
	"governorates": [
		{
			"governorateId": "1",
			"name": "إدلب"
		},
		{
			"governorateId": "2",
			"name": "الحسكة"
		},
		{
			"governorateId": "9",
			"name": "الرقة"
		},
		{
			"governorateId": "11",
			"name": "السويداء"
		},
		{
			"governorateId": "13",
			"name": "القنيطرة"
		},
		{
			"governorateId": "14",
			"name": "اللاذقية"
		},
		{
			"governorateId": "3",
			"name": "حلب"
		},
		{
			"governorateId": "4",
			"name": "حماة"
		},
		{
			"governorateId": "5",
			"name": "حمص"
		},
		{
			"governorateId": "8",
			"name": "درعا"
		},
		{
			"governorateId": "7",
			"name": "دمشق"
		},
		{
			"governorateId": "6",
			"name": "دير الزور"
		},
		{
			"governorateId": "10",
			"name": "ريف دمشق"
		},
		{
			"governorateId": "12",
			"name": "طرطوس"
		}
	]
}*/