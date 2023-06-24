// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class DoctorProfileEvents {
  DoctorProfileEvents();
}

class ChangeDropDown extends DoctorProfileEvents {
  final bool isClick;
  ChangeDropDown(this.isClick);
}

class ChangeInsurancesDropDown extends DoctorProfileEvents {
  final bool isClick;
  ChangeInsurancesDropDown(this.isClick);
}

class ChangeCommunicationDropDown extends DoctorProfileEvents {
  final bool isClick;
  ChangeCommunicationDropDown(this.isClick);
}

class ChangingMoreText extends DoctorProfileEvents {
  final bool isClick;
  ChangingMoreText(this.isClick);
}

class LoadingProfile extends DoctorProfileEvents {
  final String doctorId;
  LoadingProfile(this.doctorId);
}

class GetEvaluate extends DoctorProfileEvents {
  final String? token;
  final String doctorId;
  GetEvaluate({
    required this.token,
    required this.doctorId,
  });
}
