
import 'package:json_annotation/json_annotation.dart';

part 'insurance.g.dart';


@JsonSerializable()
class Insurance{
  List<Insurances>? insurances;
  Insurance({this.insurances});

  factory Insurance.fromJson(Map<String, dynamic> json) => _$InsuranceFromJson(json);
  Map<String, dynamic> toJson() => _$InsuranceToJson(this);
}
@JsonSerializable()
class Insurances {
  Insurances({
    this.insuranceId,
    this.companyName,
  });

  final String? insuranceId;
  final String? companyName;

  factory Insurances.fromJson(Map<String, dynamic> json) => _$InsurancesFromJson(json);
  Map<String, dynamic> toJson() => _$InsurancesToJson(this);
}