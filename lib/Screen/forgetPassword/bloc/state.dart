// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgetPasswordState {
  GetPatientId getPatientId;
  VerifyState verifyState;
  ForgetPasswordState({
    required this.getPatientId,
    required this.verifyState,
  });
}

class GetPatientId {
  String? patientId;
  String error;
  GetPatientId({
    this.patientId,
    required this.error,
  });
}

class VerifyState {
  String? message;
  String error;
  VerifyState({
    this.message,
    required this.error,
  });
}
