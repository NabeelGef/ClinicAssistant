
abstract class DoctorProfileEvents{
  DoctorProfileEvents();
}
class ChangeDropDown extends DoctorProfileEvents{
  final bool isClick;
  ChangeDropDown(this.isClick);
}
class ChangeCommunicationDropDown extends DoctorProfileEvents{
  final bool isClick;
  ChangeCommunicationDropDown(this.isClick);
}
class ChangingMoreText extends DoctorProfileEvents{
  final bool isClick;
  ChangingMoreText(this.isClick);
}
