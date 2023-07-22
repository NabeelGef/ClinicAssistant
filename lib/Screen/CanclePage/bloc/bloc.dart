import 'package:clinicassistant/Screen/CanclePage/bloc/event.dart';
import 'package:clinicassistant/Screen/CanclePage/bloc/state.dart';
import 'package:clinicassistant/model/cancle.dart';
import 'package:clinicassistant/repository/cancle_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancleBloc extends Bloc<CancleEvent, CancleStateAll> {
  CancleBloc(super.initialState);
  @override
  Stream<CancleStateAll> mapEventToState(CancleEvent event) async* {
    if (event is LoadingDataCancle) {
      yield* Loading(event.Id, event.token);
    }
    if (event is Cancling){
      yield* putcancle(event.Id, event.token);
    }
  }

  Stream<CancleStateAll> Loading(String id, String token) async* {
    yield CancleStateAll(cancelStateBloc: CancelStateBloc(cancle: null, error: "")
        , cancleSuccessState: state.cancleSuccessState);
    try {
      Cancle? cancle = await CancleRepo.getStateCancle(id, token);
      yield CancleStateAll(cancelStateBloc: CancelStateBloc(cancle: cancle, error: ""),
      cancleSuccessState: state.cancleSuccessState);
    } catch (e, stack) {
      print("Catch Error in Cancle State Bloc : $e in $stack");
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          yield CancleStateAll(cancelStateBloc: CancelStateBloc(cancle: null, error: "No Cancle"),
          cancleSuccessState: state.cancleSuccessState
          );
        }
      }
    }
  }

  Stream<CancleStateAll> putcancle(String id, String token) async*{
    yield  CancleStateAll(cancelStateBloc: state.cancelStateBloc ,
    cancleSuccessState:CancelSuccessState(message: null , error: ""));
    try{
      String? message =await CancleRepo.makeCancle(id,token);
        yield  CancleStateAll(cancelStateBloc: state.cancelStateBloc ,
        cancleSuccessState:CancelSuccessState(message: message , error: ""));

    }catch(e , stack){
      print("Error in Canclling : $e in $stack");
      yield  CancleStateAll(cancelStateBloc: state.cancelStateBloc ,
          cancleSuccessState:CancelSuccessState(message: null , error: "Not Found Any Data"));

    }
  }
}
