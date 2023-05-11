import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvents , DoctorsState> {
  AllDoctorsBloc(super.initialState);
  // when click on search button
  bool isSearch = false;
  // when click on specialist button

  //List<SubSpecialties> subspecialities = [];
  static AllDoctorsBloc get (BuildContext context){
    return BlocProvider.of(context);
  }
  Stream<DoctorsState> mapEventToState(AllDoctorsEvents events) async*{
    //when event is Search button
    if(events is SearchEventDoctor){
        yield*  _changeSearch();
    }
    if(events is LoadingDoctors){
      yield* getDoctors();
    }
    //when event is Specailist
  }
  Stream<DoctorsState> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllDoctorStates(state.doctor, "");
  }
  Stream<DoctorsState> getDoctors() async*{
     yield DoctorsState(state.doctor, "");
     try{
       Doctor? doctor = await API.getDoctors();
       if(doctor==null){
         print("In Null....");
         yield DoctorsState(state.doctor, "Failed To Load Items");
       }else{
         print("In Else....");
         yield DoctorsState(doctor, "");
       }
     }catch(e){
       print("In Catch....");
       yield DoctorsState(state.doctor, "Failed To Load Items");
     }
  }
}
class ApiSpecialistBloc extends Bloc<AllDoctorsEvents , SpecialistState>{
  ApiSpecialistBloc(SpecialistState specialistStateInitial) : super(specialistStateInitial) ;
  Specialist? dropdownmain;
  int clickspecialist = -1;
  String dropdownsub = "";
  Stream<SpecialistState> mapEventToState(AllDoctorsEvents events) async* {
     if(events is LoadingSpecialists){
       yield SpecialistState(state.specialists, "");
       try{
         yield SpecialistState(await API.getSpecialist(), "");
       }catch(e){
         yield SpecialistState(state.specialists, "Failed To Load Items");
       }
     }
     if(events is ChooseSpecialist) {
       dropdownmain = events.specialist;
       clickspecialist = events.index;
       dropdownsub = events.specialist.subSpecialties![0].subSpecialtyName!;
       yield SuccessAllSpecialStates(state.specialists, "");
     }
     if(events is ChooseSubSpecialist) {
       dropdownsub = events.sub;
       yield SuccessAllSpecialStates(state.specialists, "");
     }
   }
}