import 'package:clinicassistant/Screen/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/Screen/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:clinicassistant/repository/allDoctors_repo.dart';
import 'package:clinicassistant/repository/allSpecialist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvents, DoctorsState> {
  AllDoctorsBloc(super.initialState);
  late CheckBoxBloc checkBoxBloc;
  set SetCheckBoxBloc(CheckBoxBloc checkBoxBloc) {
    this.checkBoxBloc = checkBoxBloc;
  }

  Stream<DoctorsState> mapEventToState(AllDoctorsEvents events) async* {
    //when event is Search button
    /*  if(events is SearchEventDoctor){
        yield*  _changeSearch();
    }*/
    if (events is LoadingDoctors) {
      if (events.filterName != null ||
          events.subSpecialtyId != null ||
          events.orderByEvaluate != null) {
        checkBoxBloc.add(EditCheckAll());
      }
      yield* getDoctors(
          events.filterName, events.subSpecialtyId, events.orderByEvaluate);
    }
    //when event is Specailist
  }

  /*Stream<DoctorsState> _changeSearch() async*{
    isSearch=!isSearch;
    yield SuccessAllDoctorStates(state.doctor, "");
  }*/
  Stream<DoctorsState> getDoctors(
      String? name, int? subId, bool? isOrder) async* {
    yield DoctorsState(state.doctor, "");
    try {
      Doctor? doctor =
          await AllDoctorsRepository.getDoctors(isOrder, subId, name);
      if (doctor == null) {
        yield DoctorsState(state.doctor, "Failed To Load Items");
      } else {
        yield DoctorsState(doctor, "");
      }
    } catch (e, stack) {
      print("Catchhhhhhh in AllDoctorBloc $e in Line $stack");
      yield DoctorsState(null, "Not Found");
    }
  }
}

class ApiSpecialistBloc extends Bloc<AllDoctorsEvents, SpecialistState> {
  ApiSpecialistBloc(SpecialistState specialistStateInitial)
      : super(specialistStateInitial);
  Specialist? dropdownmain;
  int clickspecialist = -1;
  SubSpecialties? dropdownsub;
  late CheckBoxBloc checkBoxBloc;
  set SetCheckBoxBloc(CheckBoxBloc checkBoxBloc) {
    this.checkBoxBloc = checkBoxBloc;
  }

  Stream<SpecialistState> mapEventToState(AllDoctorsEvents events) async* {
    if (events is LoadingSpecialists) {
      yield SpecialistState(state.specialists, "");
      try {
        Specialists? specialists = await SpecialRepository.getSpecialist();
        if (specialists == null) {
          yield SpecialistState(specialists, "Failed To Load Items");
        } else {
          yield SpecialistState(specialists, "");
        }
      } catch (e) {
        yield SpecialistState(state.specialists, "Not Found any data");
      }
    }
    if (events is EditClickSpecialist) {
      clickspecialist = -1;
      yield SuccessAllSpecialStates(state.specialists, "");
    }
    if (events is ChooseSpecialist) {
      dropdownmain = events.specialist;
      clickspecialist = events.index;
      dropdownsub = events.specialist.subSpecialties![0];
      if (events.index != -1) {
        checkBoxBloc.add(EditCheckAll());
      }
      yield SuccessAllSpecialStates(state.specialists, "");
    }
    if (events is ChooseSubSpecialist) {
      dropdownsub = events.sub;
      yield SuccessAllSpecialStates(state.specialists, "");
    }
  }
}

class CheckBoxBloc extends Bloc<AllDoctorsEvents, List<bool>> {
  CheckBoxBloc() : super([false, true]);
  bool eval = false, all = true;
  late ApiSpecialistBloc apiSpecialistBloc;
  set SetApiSpecialBloc(ApiSpecialistBloc apiSpecialistBloc) {
    this.apiSpecialistBloc = apiSpecialistBloc;
  }

  Stream<List<bool>> mapEventToState(AllDoctorsEvents event) async* {
    if (event is CheckEvaluate) {
      eval = event.evaluate;
      if (eval) {
        yield [eval, false];
      } else {
        yield [eval, true];
      }
    }
    if (event is CheckAll) {
      apiSpecialistBloc.add(EditClickSpecialist());
      yield [false, true];
    }
    if (event is EditCheckAll) {
      yield [eval, false];
    }
  }
}
