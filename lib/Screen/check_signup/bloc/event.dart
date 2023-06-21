
import 'package:flutter/material.dart';

@immutable
abstract class CheckSignUpEvents
{
  const CheckSignUpEvents();
}

class CheckSignUpDataSend extends CheckSignUpEvents
{
  String? patientId ;
  String? verificationCode;

  CheckSignUpDataSend({
    required this.patientId,
    required this.verificationCode

  });
}

