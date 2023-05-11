import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/specialist.dart';

abstract class AllDoctorStates{
  AllDoctorStates();
}
abstract class AllSpecialStates{
  AllSpecialStates();
}


class InitialState extends AllDoctorStates{}

class SuccessAllDoctorStates extends DoctorsState{
  SuccessAllDoctorStates(super.doctor, super.error);
}
class DoctorsState extends AllDoctorStates{
  final Doctor? doctor;
  final String error;

  DoctorsState(this.doctor, this.error);

}
class SpecialistState extends AllDoctorStates{
  final Specialists? specialists;
  final String error;
  SpecialistState(this.specialists, this.error);
}

class SuccessAllSpecialStates extends SpecialistState{
  SuccessAllSpecialStates(super.specialists, super.error);
}
