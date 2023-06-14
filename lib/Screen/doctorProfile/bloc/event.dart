
abstract class DoctorProfileEvents{
  DoctorProfileEvents();
}
class ChangeDropDown extends DoctorProfileEvents{
  final bool isClick;
  ChangeDropDown(this.isClick);
}
class ChangeInsurancesDropDown extends DoctorProfileEvents{
  final bool isClick;
  ChangeInsurancesDropDown(this.isClick);
}
class ChangeCommunicationDropDown extends DoctorProfileEvents{
  final bool isClick;
  ChangeCommunicationDropDown(this.isClick);
}
class ChangingMoreText extends DoctorProfileEvents{
  final bool isClick;
  ChangingMoreText(this.isClick);
}
class LoadingProfile extends DoctorProfileEvents{
  final String doctorId;
  LoadingProfile(this.doctorId);
}
