import 'package:clinicassistant/Screen/myBookPage/bloc/event.dart';
import 'package:clinicassistant/Screen/myBookPage/bloc/state.dart';
import 'package:clinicassistant/model/current_appointment.dart';
import 'package:clinicassistant/repository/current_appointment_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBookBloc extends Bloc<MyBookEvent, MyBookState> {
  MyBookBloc(super.initialState);

  @override
  Stream<MyBookState> mapEventToState(MyBookEvent event) async* {
    if (event is LoadingMyCurrentAppointment) {
      yield* loadingCurrentAppointment(event.token);
    }
    if (event is LoadingMyPreviousAppointment) {
      yield* loadingPerviousAppointment(event.token);
    }
  }

  Stream<MyBookState> loadingCurrentAppointment(token) async* {
    yield MyBookState(
        previousMyBookState: PreviousMyBookState(
            error: state.previousMyBookState.error,
            currentAppointment: state.previousMyBookState.currentAppointment),
        currentMyBookState:
            CurrentMyBookState(error: "", currentAppointment: null));
    try {
      CurrentAppointment? currentAppointment =
          await CurrentAppointmentRepo.getAllCurrentAppointment(token);
      if (currentAppointment == null) {
        yield MyBookState(
            previousMyBookState: PreviousMyBookState(
                error: state.previousMyBookState.error,
                currentAppointment:
                    state.previousMyBookState.currentAppointment),
            currentMyBookState: CurrentMyBookState(
                error: "Not Found any Data", currentAppointment: null));
      } else {
        yield MyBookState(
            previousMyBookState: PreviousMyBookState(
                error: state.previousMyBookState.error,
                currentAppointment:
                    state.previousMyBookState.currentAppointment),
            currentMyBookState: CurrentMyBookState(
                error: "", currentAppointment: currentAppointment));
      }
    } catch (e, s) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          yield MyBookState(
              previousMyBookState: PreviousMyBookState(
                  error: state.previousMyBookState.error,
                  currentAppointment:
                      state.previousMyBookState.currentAppointment),
              currentMyBookState: CurrentMyBookState(
                  error: "Not Found", currentAppointment: null));
        } else {
          yield MyBookState(
              previousMyBookState: PreviousMyBookState(
                  error: "",
                  currentAppointment:
                      state.currentMyBookState.currentAppointment),
              currentMyBookState: CurrentMyBookState(
                  error: "Not Found any data", currentAppointment: null));
        }
      }
      print("Error in CurrentMyBook is : $e in $s");
    }
  }

  Stream<MyBookState> loadingPerviousAppointment(token) async* {
    yield MyBookState(
        previousMyBookState:
            PreviousMyBookState(error: "", currentAppointment: null),
        currentMyBookState: CurrentMyBookState(
            error: state.currentMyBookState.error,
            currentAppointment: state.currentMyBookState.currentAppointment));
    try {
      CurrentAppointment? currentAppointment =
          await CurrentAppointmentRepo.getAllPreviousAppointment(token);
      if (currentAppointment == null) {
        yield MyBookState(
            previousMyBookState:
                PreviousMyBookState(error: "", currentAppointment: null),
            currentMyBookState: CurrentMyBookState(
                error: state.currentMyBookState.error,
                currentAppointment:
                    state.currentMyBookState.currentAppointment));
      } else {
        yield MyBookState(
            previousMyBookState: PreviousMyBookState(
                error: state.currentMyBookState.error,
                currentAppointment: currentAppointment),
            currentMyBookState: state
                .currentMyBookState /*CurrentMyBookState(
                error: "",
                currentAppointment:
                    state.currentMyBookState.currentAppointment)*/
            );
      }
    } catch (e, s) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          yield MyBookState(
              previousMyBookState: PreviousMyBookState(
                  error: "Not Found", currentAppointment: null),
              currentMyBookState: CurrentMyBookState(
                  error: state.currentMyBookState.error,
                  currentAppointment:
                      state.currentMyBookState.currentAppointment));
        } else {
          yield MyBookState(
              previousMyBookState: PreviousMyBookState(
                  error: "Not Found Any Data", currentAppointment: null),
              currentMyBookState: CurrentMyBookState(
                  error: "Not Found any data",
                  currentAppointment:
                      state.currentMyBookState.currentAppointment));
        }
      }
      print("Error in PreviousMyBook is : $e in $s");
    }
  }
}
