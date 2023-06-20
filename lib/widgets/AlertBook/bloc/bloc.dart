import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/worktime.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class AlertBookBloc extends Bloc<AlertBookEvent, StateAlertBook> {
  AlertBookBloc(super.initialState);

  @override
  Stream<StateAlertBook> mapEventToState(AlertBookEvent event) async* {
    if (event is LoadingEventAlertBook) {
      yield* Loading(event.doctorId, event.clinicId);
    }
    if (event is LoadingEventAlertBookClock) {
      yield* LoadingClocks(event.workTimeId);
    }
    if (event is SelectTime) {
      var selected = event.selected;
      for (int i = 0; i < selected.length; i++) {
        if (event.index == i) {
          selected[i][2] = true;
        } else {
          selected[i][2] = false;
        }
      }
      yield StateAlertBook(
          successAlertBook: state.successAlertBook,
          successAlertBookClock: state.successAlertBookClock,
          selectState: SelectState(myIndex: event.index, selected: selected));
    }
    if (event is LoadingEventRemaining) {
      yield* LoadingRemaining(event.appointmentId);
    }
    if (event is BookNowEvent) {
      yield* LoadingBook(event.appointmentId, event.token);
    }
  }

  Stream<StateAlertBook> Loading(String doctorId, String clinicId) async* {
    yield StateAlertBook(
        successAlertBookClock: state.successAlertBookClock,
        successAlertBook: SuccessAlertBook(workTime: null, error: ""));
    try {
      WorkTime? workTime = await API.getWorkTime(doctorId, clinicId);
      if (workTime == null) {
        yield StateAlertBook(
            successAlertBookClock: state.successAlertBookClock,
            successAlertBook:
                SuccessAlertBook(workTime: null, error: "Not Found"));
      } else {
        yield StateAlertBook(
          successAlertBookClock: state.successAlertBookClock,
          successAlertBook: SuccessAlertBook(workTime: workTime, error: ""),
        );
      }
    } catch (e, s) {
      print("Error In WorkTimes is : $e ,in $s");
      yield StateAlertBook(
          successAlertBookClock: state.successAlertBookClock,
          successAlertBook:
              SuccessAlertBook(workTime: null, error: "Not Found any data"));
    }
  }

  Stream<StateAlertBook> LoadingClocks(String workTimeId) async* {
    yield StateAlertBook(
        successAlertBookClock:
            SuccessAlertBookClock(workTimeClock: null, error: ""),
        successAlertBook: state.successAlertBook);
    try {
      WorkTimeClock? workTimeClock = await API.getWorkTimeClocks(workTimeId);
      if (workTimeClock == null) {
        yield StateAlertBook(
            successAlertBookClock:
                SuccessAlertBookClock(workTimeClock: null, error: "Not Found"),
            successAlertBook: state.successAlertBook);
      } else {
        List<Map<int, bool>> selected =
            List.generate(workTimeClock.appointment!.length, (index) {
          return {index: false};
        });
        yield StateAlertBook(
            successAlertBookClock:
                SuccessAlertBookClock(workTimeClock: workTimeClock, error: ""),
            successAlertBook: state.successAlertBook,
            selectState: SelectState(myIndex: -1, selected: selected));
      }
    } catch (e, s) {
      print("Error In WorkTimesClock is : $e ,in $s");
      yield StateAlertBook(
          successAlertBookClock: SuccessAlertBookClock(
              workTimeClock: null, error: "Not Found any data"),
          successAlertBook: state.successAlertBook);
    }
  }

  Stream<StateAlertBook> LoadingRemaining(String appointmentId) async* {
    yield StateAlertBook(
        successAlertBook: state.successAlertBook,
        successAlertBookClock: state.successAlertBookClock,
        selectState: state.selectState,
        successRemain: SuccessRemain(message: null, error: ""));
    try {
      String? message = await API.getRemainClocks(appointmentId);
      if (message == null) {
        yield StateAlertBook(
            successAlertBook: state.successAlertBook,
            successAlertBookClock: state.successAlertBookClock,
            selectState: state.selectState,
            successRemain: SuccessRemain(message: null, error: "Not Found"));
      } else {
        yield StateAlertBook(
            successAlertBook: state.successAlertBook,
            successAlertBookClock: state.successAlertBookClock,
            selectState: state.selectState,
            successRemain: SuccessRemain(message: message, error: ""));
      }
    } catch (e, s) {
      print("Error in Remain API is : $e in Line $s");
      yield StateAlertBook(
          successAlertBook: state.successAlertBook,
          successAlertBookClock: state.successAlertBookClock,
          selectState: state.selectState,
          successRemain:
              SuccessRemain(message: null, error: "Not Found any data"));
    }
  }

  Stream<StateAlertBook> LoadingBook(
      String appointmentId, String token) async* {
    yield StateAlertBook(
        successAlertBook: state.successAlertBook,
        successAlertBookClock: state.successAlertBookClock,
        selectState: state.selectState,
        successRemain: state.successRemain,
        successBook: SuccessBook(message: null, error: ""));
    try {
      String? message = await API.booknow(appointmentId, token);
      if (message == null) {
        yield StateAlertBook(
            successAlertBook: state.successAlertBook,
            successAlertBookClock: state.successAlertBookClock,
            selectState: state.selectState,
            successRemain: state.successRemain,
            successBook: SuccessBook(message: null, error: "Not Found"));
      } else {
        yield StateAlertBook(
            successAlertBook: state.successAlertBook,
            successAlertBookClock: state.successAlertBookClock,
            selectState: state.selectState,
            successRemain: state.successRemain,
            successBook: SuccessBook(message: message, error: ""));
      }
    } catch (e, s) {
      print("Error in Book API is : $e in Line $s");
      yield StateAlertBook(
          successAlertBook: state.successAlertBook,
          successAlertBookClock: state.successAlertBookClock,
          selectState: state.selectState,
          successRemain: state.successRemain,
          successBook: SuccessBook(message: null, error: "Not Found any data"));
    }
  }
}
