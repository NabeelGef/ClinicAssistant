import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvents , AllDoctorStates> {
  AllDoctorsBloc(super.initialState);
  // when click on search button
  bool isSearch = false;
  // when click on specialist button
  int clickspecialist = -1;

  List<SubSpecialties> subspecialities = [];
  static AllDoctorsBloc get (BuildContext context){
    return BlocProvider.of(context);
  }
  Stream<AllDoctorStates> mapEventToState(AllDoctorsEvents events) async*{
    //when event is Search button
    if(events is SearchEventDoctor){
        yield*  _changeSearch();
      }
    //when event is Specailist
      if(events is ChooseSpecialist){
        yield* _changeValue(events.index , events.subspecialties);
      }
  }
  Stream<AllDoctorStates> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllDoctorStates();
  }
  Stream<AllDoctorStates> _changeValue(int index, List<SubSpecialties> subspecialties) async*{
    clickspecialist = index;
    subspecialities = subspecialties;
    yield SuccessAllDoctorStates();
  }
}