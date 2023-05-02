import 'package:clinicassistant/Screen/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllClinicsBloc extends Bloc<AllClinicsEvents , AllClinicStates> {
  AllClinicsBloc(super.initialState);
  // when click on search button
  bool isSearch = false;
  static AllClinicsBloc get (BuildContext context){
    return BlocProvider.of(context);
  }
  @override
  Stream<AllClinicStates> mapEventToState(AllClinicsEvents events) async*{
    //when event is Search button

    if(events is SearchEventClinic){
        yield*  _changeSearch();
      }
  }
  Stream<AllClinicStates> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllClinicStates();
  }
}