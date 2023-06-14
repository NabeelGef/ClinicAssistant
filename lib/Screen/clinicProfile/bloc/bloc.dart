import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Screen/clinicProfile/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicProfile/bloc/state.dart';
import 'package:clinicassistant/model/profileClinic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicProfileBloc extends Bloc<ClinicProfileEvent, SuccessProfileStates> {
  ClinicProfileBloc(super.initialState);

  Stream<SuccessProfileStates> mapEventToState(
      ClinicProfileEvent event) async* {
    if (event is LoadingProfile) {
      yield* getProfileInfo(event.clinicId);
    }
  }

  Stream<SuccessProfileStates> getProfileInfo(String clinicId) async* {
    yield SuccessProfileStates(null, "");
    try {
      ProfileClinic? profileClinic = await API.getDetailClinic(clinicId);
      if (profileClinic == null) {
        yield SuccessProfileStates(null, "Couldn't Find any Data!!");
      } else {
        yield SuccessProfileStates(profileClinic, "");
      }
    } catch (e) {
      print(e);
      yield SuccessProfileStates(null, "Error In Connection");
    }
  }
}
