import 'package:clinicassistant/Screen/doctorProfile/bloc/event.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvents , List<String>>{
  DoctorProfileBloc(super.initialState);

  Stream<List<String>> mapEventToState(DoctorProfileEvents events) async*{
    if(events is ChangeDropDown){
      yield* ChangingImage(events.isClick);
    }
    if(events is ChangeCommunicationDropDown){
      yield* ChangingImageComm(events.isClick);
    }
    if(events is ChangingMoreText){
      yield* Changingmore(events.isClick);
    }
    //when event is Specailist
  }
  String imagedetail = "moredrop.png";
  String imagecommunication = "moredrop.png";
  String textMore = "عرض المزيد";
  Stream<List<String>> ChangingImage(bool isClick) async*{
    if(!isClick){
      imagedetail = "moredrop.png";
      yield [imagedetail , imagecommunication , textMore];
      //DropDownStates("moredrop.png");
    }else{
      imagedetail = "lessdrop.png";
      yield [imagedetail , imagecommunication, textMore];
      //yield DropDownStates("lessdrop.png");
    }
  }

  Stream <List<String>> ChangingImageComm(bool isClick) async*{
    if(!isClick){
      imagecommunication = "moredrop.png";
      yield [imagedetail , imagecommunication, textMore];
      //yield DropDownStates("moredrop.png");
    }else{
      imagecommunication = "lessdrop.png";
      yield [imagedetail , imagecommunication, textMore];
      //yield DropDownStates("lessdrop.png");
    }
  }

  Stream<List<String>> Changingmore(bool isClick) async*{
    if(!isClick){
      textMore = "عرض المزيد";
      yield [imagedetail , imagecommunication, textMore];

    //yield DropDownStates("moredrop.png");
    }else{
      textMore = "إخفاء";
      yield [imagedetail , imagecommunication, textMore];
    //yield DropDownStates("lessdrop.png");
    }
  }
}
