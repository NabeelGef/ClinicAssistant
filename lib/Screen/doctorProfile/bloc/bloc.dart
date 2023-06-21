import 'package:clinicassistant/Screen/doctorProfile/bloc/event.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/state.dart';
import 'package:clinicassistant/model/profileDoctor.dart';
import 'package:clinicassistant/repository/doctor_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvents, List<String>> {
  DoctorProfileBloc(super.initialState);

  Stream<List<String>> mapEventToState(DoctorProfileEvents events) async* {
    if (events is ChangeDropDown) {
      yield* ChangingImage(events.isClick);
    }
    if (events is ChangeCommunicationDropDown) {
      yield* ChangingImageComm(events.isClick);
    }
    if (events is ChangingMoreText) {
      yield* Changingmore(events.isClick);
    }
    if (events is ChangeInsurancesDropDown) {
      yield* ChangingImageInsurance(events.isClick);
    }
    //when event is Specailist
  }

  String imagedetail = "moredrop.png";
  String imagecommunication = "moredrop.png";
  String imageInsurances = "moredrop.png";
  String textMore = "عرض المزيد";
  Stream<List<String>> ChangingImage(bool isClick) async* {
    if (!isClick) {
      imagedetail = "moredrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
      //DropDownStates("moredrop.png");
    } else {
      imagedetail = "lessdrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
      //yield DropDownStates("lessdrop.png");
    }
  }

  Stream<List<String>> ChangingImageInsurance(bool isClick) async* {
    if (!isClick) {
      imageInsurances = "moredrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
    } else {
      imageInsurances = "lessdrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
    }
  }

  Stream<List<String>> ChangingImageComm(bool isClick) async* {
    if (!isClick) {
      imagecommunication = "moredrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
      //yield DropDownStates("moredrop.png");
    } else {
      imagecommunication = "lessdrop.png";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
      //yield DropDownStates("lessdrop.png");
    }
  }

  Stream<List<String>> Changingmore(bool isClick) async* {
    if (!isClick) {
      textMore = "عرض المزيد";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];

      //yield DropDownStates("moredrop.png");
    } else {
      textMore = "إخفاء";
      yield [imagedetail, imagecommunication, textMore, imageInsurances];
      //yield DropDownStates("lessdrop.png");
    }
  }
}

class DoctorProfileDataBloc
    extends Bloc<DoctorProfileEvents, SuccessProfileStates> {
  DoctorProfileDataBloc(super.initialState);

  @override
  Stream<SuccessProfileStates> mapEventToState(
      DoctorProfileEvents event) async* {
    if (event is LoadingProfile) {
      yield* getProfileInfo(event.doctorId);
    }
  }

  Stream<SuccessProfileStates> getProfileInfo(String id) async* {
    yield SuccessProfileStates(null, "");
    try {
      ProfileDoctor? profileDoctor =
          await DoctorProfileRepository.getDetailDoctor(id);
      if (profileDoctor == null) {
        yield SuccessProfileStates(null, "Couldn't Find any Data!!");
      } else {
        yield SuccessProfileStates(profileDoctor, "");
      }
    } catch (e) {
      yield SuccessProfileStates(null, "Not Found any data");
    }
  }
}
