
import 'package:flutter/material.dart';

@immutable
abstract class ClinicProfileEvent{
  ClinicProfileEvent();
}

class LoadingProfile extends ClinicProfileEvent{
  final String clinicId;
  LoadingProfile(this.clinicId);
}


