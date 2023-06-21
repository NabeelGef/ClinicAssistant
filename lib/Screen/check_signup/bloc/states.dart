
import 'package:flutter/material.dart';

@immutable
abstract class CheckSignUpStates
{
  const CheckSignUpStates();
}

class InitialCheckSignUpStates extends CheckSignUpStates
{

}

class SuccessCheckSignUpStates extends CheckSignUpStates
{
  final String successMessage;
  SuccessCheckSignUpStates(this.successMessage);
}

class ErrorCheckSignUpStates extends CheckSignUpStates
{

}

class LoadingCheckSignUpStates extends CheckSignUpStates
{

}