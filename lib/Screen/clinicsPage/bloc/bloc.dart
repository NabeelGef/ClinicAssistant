import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/clinicsPage/bloc/states.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllClinicsBloc extends Bloc<AllClinicsEvents , ClinicsStates> {
  AllClinicsBloc(super.initialState);
  // when click on search button
  /*bool isSearch = false;
  static AllClinicsBloc get (BuildContext context){
    return BlocProvider.of(context);
  }*/
  @override
  Stream<ClinicsStates> mapEventToState(AllClinicsEvents events) async*{

    if(events is LoadingClinics){
        yield*  getClinics();
      }
  }
  /*Stream<AllClinicStates> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllClinicStates();
  }*/

  Stream<ClinicsStates> getClinics() async*{
    yield ClinicsStates(state.clinic, "");
    try{
      Clinic? clinic = await API.getClinics();
      if(clinic==null){
        yield ClinicsStates(state.clinic, "Failed To Load Items");
      }else{
        print("In Else....");
        yield ClinicsStates(clinic, "");
      }
    }catch(e){
      print("In Catch....$e");
      yield ClinicsStates(state.clinic, "Failed To Load Items");
    }
  }
}