
abstract class DoctorProfileState{
  DoctorProfileState();
}

class DropDownStates extends DoctorProfileState{
  final String imageurl;
  DropDownStates(this.imageurl);
}
class CommunicationDropDownStates extends DoctorProfileState{
  final String imageurl;
  CommunicationDropDownStates(this.imageurl);

}