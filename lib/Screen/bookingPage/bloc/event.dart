// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BookEvent {
  BookEvent();
}

class ChangeCommunicationDropDown extends BookEvent {
  final bool isClick;
  ChangeCommunicationDropDown(this.isClick);
}

class ChangeSpecialDropDown extends BookEvent {
  final bool isClick;
  ChangeSpecialDropDown(this.isClick);
}

class ChangeAddressDropDown extends BookEvent {
  final bool isClick;
  ChangeAddressDropDown(this.isClick);
}

class LoadingBooking extends BookEvent {
  final String doctorId;
  final String clinicId;
  final String token;
  LoadingBooking(
    this.doctorId,
    this.clinicId,
    this.token,
  );
}
