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
  late CheckBoxBloc checkBoxBloc;
  set SetCheckBoxBloc(CheckBoxBloc checkBoxBloc){
    this.checkBoxBloc = checkBoxBloc;
  }
  Stream<SpecialistState> mapEventToState(AllDoctorsEvents events) async* {
     if(events is LoadingSpecialists){
       yield SpecialistState(state.specialists, "");
       try{
         Specialists? specialists = await API.getSpecialist();
         if(specialists==null){
           yield SpecialistState(specialists, "Failed To Load Items");
         }else{
           yield SpecialistState(specialists, "");
         }
       }catch(e){
         yield SpecialistState(state.specialists, "Failed To Load Items");
       }
     }
     if(events is EditClickSpecialist){
       clickspecialist = -1;
       yield SuccessAllSpecialStates(state.specialists, "");
     }
     if(events is ChooseSpecialist) {
       dropdownmain = events.specialist;
       clickspecialist = events.index;
       dropdownsub = events.specialist.subSpecialties![0].subSpecialtyName!;
       checkBoxBloc.add(EditCheckAll());
       yield SuccessAllSpecialStates(state.specialists, "");
     }
     if(events is ChooseSubSpecialist) {
       dropdownsub = events.sub;
       yield SuccessAllSpecialStates(state.specialists, "");
     }
   }
}
class CheckBoxBloc extends Bloc<AllDoctorsEvents , List<bool>>{
  CheckBoxBloc() : super([false , true]);
  bool eval  = false, all = true;
 late ApiSpecialistBloc apiSpecialistBloc;
 set SetApiSpecialBloc(ApiSpecialistBloc apiSpecialistBloc){
   this.apiSpecialistBloc = apiSpecialistBloc;
 }
  Stream<List<bool>> mapEventToState(AllDoctorsEvents event) async*{
    if(event is CheckEvaluate){
      eval = event.evaluate;
      yield [event.evaluate , all];
    }
    if(event is CheckAll){
      if(apiSpecialistBloc.clickspecialist==-1){
        yield [eval , true];
        // بسبب عدم اختيارك نوع الفلترة
      }else{
        all = event.evaluate;
        apiSpecialistBloc.add(EditClickSpecialist());
        yield [eval , event.evaluate];
      }
    }
    if(event is EditCheckAll){
      yield[eval , false];
    }
  }
}