
import 'package:flutter/material.dart';

@immutable
abstract class SignUpStates
{
  const SignUpStates();
}

class InitialSignUpStates extends SignUpStates
{

}

class SuccessSignUpStates extends SignUpStates
{

}

class ErrorSignUpStates extends SignUpStates
{

}