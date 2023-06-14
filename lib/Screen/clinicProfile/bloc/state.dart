import 'package:clinicassistant/model/profileClinic.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ClinicProfileState{
  ClinicProfileState();
}


class SuccessProfileStates extends ClinicProfileState{
  final ProfileClinic? profileClinic;
  final String error;
  SuccessProfileStates(this.profileClinic, this.error);
}