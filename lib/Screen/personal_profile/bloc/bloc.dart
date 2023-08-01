import 'dart:io';

import 'package:clinicassistant/Screen/personal_profile/bloc/event.dart';
import 'package:clinicassistant/Screen/personal_profile/bloc/states.dart';
import 'package:clinicassistant/model/personl_information.dart';
import 'package:clinicassistant/repository/edit_personal_profile_repo.dart';
import 'package:clinicassistant/repository/get_personal_information_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalProfileBloc
    extends Bloc<PersonalProfileEvents, PersonalProfileStates> {
  PersonalProfileBloc(super.initialState);

  @override
  Stream<PersonalProfileStates> mapEventToState(
      PersonalProfileEvents event) async* {
    if (event is LoadingPersonalProfile) {
      yield* loadingPersonalProfile(event.token);
    }
    if (event is EditImageProfile) {
      yield* getImage(event.image, event.token);
    }
  }

  Stream<PersonalProfileStates> loadingPersonalProfile(String token) async* {
    yield PersonalProfileStates(
        getAccount: GetAccount(personalInformation: null, error: ''),
        getNewImage: state.getNewImage);

    try {
      Patient? patient = await GetPersonalInformationRepo.getMyAccount(token);
      if (patient == null) {
        yield PersonalProfileStates(
            getAccount: GetAccount(
                personalInformation: null, error: 'Not Found Any Data'),
            getNewImage: state.getNewImage);
      } else {
        yield PersonalProfileStates(
            getAccount: GetAccount(personalInformation: patient, error: ''),
            getNewImage: state.getNewImage);
      }
    } catch (e, stack) {
      print("Error in Get Account is $e in $stack");
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          yield PersonalProfileStates(
              getAccount:
                  GetAccount(personalInformation: null, error: 'Not Found'),
              getNewImage: state.getNewImage);
        } else {
          yield PersonalProfileStates(
              getAccount: GetAccount(
                  personalInformation: null, error: 'Not Found Any Data'),
              getNewImage: state.getNewImage);
        }
      }
    }
  }

  Stream<PersonalProfileStates> getImage(File? image, String token) async* {
    yield PersonalProfileStates(
        getAccount: state.getAccount, getNewImage: GetNewImage(image: image));
    try {
      String? data = await EditPersonalProfile.editProfile(image, token);
      print("data Form Edit Profile : $data");
    } catch (e, stack) {
      print("Error In Edit Image Profile $e is $stack");
    }
  }
}
