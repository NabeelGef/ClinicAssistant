// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/cancle.dart';

class CancleStateAll{
  CancelStateBloc? cancelStateBloc;
  CancelSuccessState? cancleSuccessState;
  CancleStateAll({this.cancelStateBloc, this.cancleSuccessState});
}
class CancelStateBloc {
  Cancle? cancle;
  String? error;
  CancelStateBloc({
    this.cancle,
    this.error,

  });
}
class CancelSuccessState{
 String? message;
 String? error;
 CancelSuccessState({this.message, this.error});
}
