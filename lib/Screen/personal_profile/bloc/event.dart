import 'package:flutter/material.dart';

@immutable
abstract class PersonalProfileEvents
{
  const PersonalProfileEvents();
}

class GetPersonalInformation extends PersonalProfileEvents
{

}

class LoadingPersonalProfile extends PersonalProfileEvents
{

}
