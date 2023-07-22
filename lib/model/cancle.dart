import 'package:json_annotation/json_annotation.dart';

part 'cancle.g.dart';

@JsonSerializable()
class Cancle {
  CancelState? cancelState;

  Cancle({this.cancelState});

  factory Cancle.fromJson(Map<String, dynamic> json) => _$CancleFromJson(json);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.cancelState != null) {
  //     data['cancelState'] = this.cancelState!.toJson();
  //   }
  //   return data;
  // }
}

@JsonSerializable()
class CancelState {
  bool? canCancel;
  int? numberOfMissAppointment;

  CancelState({this.canCancel, this.numberOfMissAppointment});

  factory CancelState.fromJson(Map<String, dynamic> json) =>
      _$CancelStateFromJson(json);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['canCancel'] = this.canCancel;
  //   data['numberOfMissAppointment'] = this.numberOfMissAppointment;
  //   return data;
  // }
}
