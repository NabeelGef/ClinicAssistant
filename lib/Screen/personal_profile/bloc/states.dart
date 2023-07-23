
import 'package:clinicassistant/model/personl_information.dart';

abstract class PersonalProfileStates
{
  PersonalProfileStates();
}

class SuccessPersonalProfileStates extends PersonalProfileStates {

  final PersonalInformation? personalInformation;
  final String error;

  SuccessPersonalProfileStates(this.error , this.personalInformation);

}

