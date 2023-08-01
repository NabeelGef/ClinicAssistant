// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgetPasswordEvent {
  ForgetPasswordEvent();
}

class AddNumberPhone extends ForgetPasswordEvent {
  String numberPhone;
  AddNumberPhone({
    required this.numberPhone,
  });
}

class Verify extends ForgetPasswordEvent {
  String patientId;
  String code;
  String newPassword;
  Verify({
    required this.patientId,
    required this.code,
    required this.newPassword,
  });
}
