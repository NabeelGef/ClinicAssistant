import 'package:clinicassistant/Screen/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/states.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/repository/allClinics_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllClinicsBloc extends Bloc<AllClinicsEvents, ClinicsStates> {
  AllClinicsBloc(super.initialState);
  // when click on search button
  /*bool isSearch = false;
  static AllClinicsBloc get (BuildContext context){
    return BlocProvider.of(context);
  }*/
  @override
  Stream<ClinicsStates> mapEventToState(AllClinicsEvents events) async* {
    if (events is LoadingClinics) {
      yield* getClinics();
    }
    if (events is SearchEventClinic) {
      yield* getClinicsByName(events.name);
    }
  }
  /*Stream<AllClinicStates> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllClinicStates();
  }*/

  Stream<ClinicsStates> getClinics() async* {
    yield ClinicsStates(state.clinic, "");
    try {
      Clinic? clinic = await AllClinicsRepository.getClinics();
      if (clinic == null) {
        yield ClinicsStates(state.clinic, "Failed To Load Items");
      } else {
        yield ClinicsStates(clinic, "");
      }
    } catch (e, s) {
      print("In Catch All Clinic....$e in $s");
      yield ClinicsStates(null, "Not Found any data");
    }
  }

  Stream<ClinicsStates> getClinicsByName(String name) async* {
    yield ClinicsStates(state.clinic, "");
    try {
      Clinic? clinic = await AllClinicsRepository.SearchClininByName(name);
      if (clinic == null) {
        yield ClinicsStates(state.clinic, "Failed To Load Items");
      } else {
        yield ClinicsStates(clinic, "");
      }
    } catch (e, s) {
      print("In Catch Search Clinic....$e in $s");
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          yield ClinicsStates(null, "Not Found");
        } else {
          yield ClinicsStates(null, "Not Found any data");
        }
      }
    }
  }
}
