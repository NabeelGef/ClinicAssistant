import 'package:clinicassistant/Screen/forgetPassword/bloc/event.dart';
import 'package:clinicassistant/Screen/forgetPassword/bloc/state.dart';
import 'package:clinicassistant/repository/forget_password_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc(super.initialState);
  @override
  Stream<ForgetPasswordState> mapEventToState(
      ForgetPasswordEvent event) async* {
    if (event is AddNumberPhone) {
      yield* getPatientId(event.numberPhone);
    }
    if (event is Verify) {
      yield* verify(event.patientId, event.code, event.newPassword);
    }
  }

  Stream<ForgetPasswordState> getPatientId(String numberPhone) async* {
    yield ForgetPasswordState(
        getPatientId: GetPatientId(patientId: null, error: ''),
        verifyState: state.verifyState);
    try {
      String? patientId = await ForgetPasswordRepo.getPatientId(numberPhone);
      if (patientId == null) {
        yield ForgetPasswordState(
            getPatientId: GetPatientId(patientId: null, error: 'Not Found'),
            verifyState: state.verifyState);
      } else {
        yield ForgetPasswordState(
            getPatientId: GetPatientId(patientId: patientId, error: ''),
            verifyState: state.verifyState);
      }
    } catch (e, stack) {
      print("Error In Forget Password is $e in $stack");
      yield ForgetPasswordState(
          getPatientId: GetPatientId(patientId: null, error: 'Not Found'),
          verifyState: state.verifyState);
    }
  }

  Stream<ForgetPasswordState> verify(
      String patientId, String code, String newPassword) async* {
    yield ForgetPasswordState(
        getPatientId: state.getPatientId,
        verifyState: VerifyState(message: null, error: ""));
    try {
      String? message =
          await ForgetPasswordRepo.verify(patientId, code, newPassword);
      if (message == null) {
        yield ForgetPasswordState(
            getPatientId: state.getPatientId,
            verifyState: VerifyState(message: null, error: "Not Found"));
      } else {
        yield ForgetPasswordState(
            getPatientId: state.getPatientId,
            verifyState: VerifyState(message: message, error: ""));
      }
    } catch (e, stack) {
      if (e is DioException) {
        print("Errrroooooooooo : ${e.response?.data}");
      }
      print("Error when Verify Password is $e in $stack");
      yield ForgetPasswordState(
          getPatientId: state.getPatientId,
          verifyState: VerifyState(message: null, error: "Not Found"));
    }
  }
}
