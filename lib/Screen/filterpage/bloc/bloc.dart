import 'package:clinicassistant/Screen/filterpage/bloc/event.dart';
import 'package:clinicassistant/Screen/filterpage/bloc/state.dart';
import 'package:clinicassistant/model/doctor.dart';
import 'package:clinicassistant/model/insurance.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:clinicassistant/repository/allDoctors_repo.dart';
import 'package:clinicassistant/repository/allSpecialist_repo.dart';
import 'package:clinicassistant/repository/all_Insurances_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteringBloc extends Bloc<FilterEvent, FilteringState> {
  FilteringBloc(super.initialState);
  @override
  Stream<FilteringState> mapEventToState(FilterEvent event) async* {
    if (event is LoadingDoctorsFiltirng) {
      yield* loadingDoctorsWithFiltre(
          event.subSpecialtyId, event.insuranceId, event.gender);
    }
  }

  Stream<FilteringState> loadingDoctorsWithFiltre(
      int? subSpecialtyId, int? insuranceId, String? gender) async* {
    yield FilteringState(
      successFilterDoctorState:
          SuccessFilterDoctorState(doctor: null, error: ''),
    );
    try {
      Doctor? doctor = await AllDoctorsRepository.filterDoctors(
          subSpecialtyId, insuranceId, gender);
      if (doctor == null) {
        yield FilteringState(
          successFilterDoctorState: SuccessFilterDoctorState(
              doctor: null, error: 'Not Found Any Data'),
        );
      } else {
        yield FilteringState(
          successFilterDoctorState:
              SuccessFilterDoctorState(doctor: doctor, error: ''),
        );
      }
    } catch (e, stack) {
      print("Error when Filter Doctors is $e in $stack");
      if (e is DioException) {
        print("Exception is ::::::::::::::::: ${e.response!.data}");
      }
      yield FilteringState(
        successFilterDoctorState:
            SuccessFilterDoctorState(doctor: null, error: 'Not Found Any Data'),
      );
    }
  }
}

class FilteringBlocSpecialAndInsurance
    extends Bloc<FilterEvent, SpecialAndInsuranceState> {
  FilteringBlocSpecialAndInsurance(super.initialState);
  Specialist? specialist;
  SubSpecialties? subSpecialties;
  int clickspecialist = -1;
  String? gender;
  Insurances? insurance;
  @override
  Stream<SpecialAndInsuranceState> mapEventToState(FilterEvent event) async* {
    if (event is LoadingSpecialistsFiltring) {
      yield* loadingSpecilaists();
    }
    if (event is LoadingInsurancesFiltring) {
      yield* loadingInsurances();
    }
    if (event is ChooseSpecialist) {
      specialist = event.specialist;
      clickspecialist = event.index;
      subSpecialties = event.specialist.subSpecialties![0];
      yield SpecialAndInsuranceState(
        successInsurancesState: state.successInsurancesState,
        successSpecialistsState: state.successSpecialistsState,
      );
    }
    if (event is ChooseSubSpecialist) {
      subSpecialties = event.sub;
      yield SpecialAndInsuranceState(
        successInsurancesState: state.successInsurancesState,
        successSpecialistsState: state.successSpecialistsState,
      );
    }

    if (event is ChooseInsurance) {
      insurance = event.insurance;
      yield SpecialAndInsuranceState(
          successInsurancesState: state.successInsurancesState,
          successSpecialistsState: state.successSpecialistsState);
    }
    if (event is ChooseGender) {
      gender = event.gender;
      yield SpecialAndInsuranceState(
          successInsurancesState: state.successInsurancesState,
          successSpecialistsState: state.successSpecialistsState);
    }
    if (event is Reset) {
      gender = null;
      specialist = null;
      subSpecialties = null;
      clickspecialist = -1;
      insurance = null;
      yield SpecialAndInsuranceState(
          successInsurancesState: state.successInsurancesState,
          successSpecialistsState: state.successSpecialistsState);
    }
  }

  Stream<SpecialAndInsuranceState> loadingSpecilaists() async* {
    yield SpecialAndInsuranceState(
        successSpecialistsState:
            SuccessSpecialistsState(specialists: null, error: ''),
        successInsurancesState: state.successInsurancesState);
    try {
      Specialists? specialists = await SpecialRepository.getSpecialist();
      if (specialists == null) {
        yield SpecialAndInsuranceState(
            successSpecialistsState: SuccessSpecialistsState(
                specialists: null, error: 'Not Found Any Data'),
            successInsurancesState: state.successInsurancesState);
      } else {
        yield SpecialAndInsuranceState(
            successSpecialistsState:
                SuccessSpecialistsState(specialists: specialists, error: ''),
            successInsurancesState: state.successInsurancesState);
      }
    } catch (e, stack) {
      print("Error in Get Specialists Filtering is $e in $stack");
    }
  }

  Stream<SpecialAndInsuranceState> loadingInsurances() async* {
    yield SpecialAndInsuranceState(
        successSpecialistsState: state.successSpecialistsState,
        successInsurancesState:
            SuccessInsurancesState(insurance: null, error: ''));
    try {
      Insurance? insurances = await AllInsurancesRepo.getAllInsurances();
      if (insurances == null) {
        yield SpecialAndInsuranceState(
            successSpecialistsState: state.successSpecialistsState,
            successInsurancesState: SuccessInsurancesState(
                insurance: null, error: 'Not Found Any Data'));
      } else {
        yield SpecialAndInsuranceState(
            successSpecialistsState: state.successSpecialistsState,
            successInsurancesState:
                SuccessInsurancesState(insurance: insurances, error: ''));
      }
    } catch (e, stack) {
      print("Error in Get All Insurance When Filtereing is $e in $stack");
    }
  }
}
