import 'package:clinicassistant/model/worktime.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:clinicassistant/repository/BookRepository/book_now_repo.dart';
import 'package:clinicassistant/repository/BookRepository/clock_time_repo.dart';
import 'package:clinicassistant/repository/BookRepository/remain_repo.dart';
import 'package:clinicassistant/repository/BookRepository/work_time_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class AlertBookBloc extends Bloc<AlertBookEvent, StateAlertBook> {
  AlertBookBloc(super.initialState);

  @override
  Stream<StateAlertBook> mapEventToState(AlertBookEvent event) async* {
    if (event is LoadingEventAlertBook) {
      yield* Loading(event.doctorId, event.clinicId, event.token);
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

  Stream<StateAlertBook> Loading(
      String doctorId, String clinicId, String token) async* {
    yield StateAlertBook(
        successAlertBookClock: state.successAlertBookClock,
        successAlertBook: SuccessAlertBook(workTime: null, error: ""));
    try {
      WorkTime? workTime =
          await WorkTimeRepository.getWorkTime(doctorId, clinicId, token);
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
      WorkTimeClock? workTimeClock = await ClockTimeRepository.getWorkTimeClocks(
          workTimeId,
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXRpZW50SWQiOiIxIiwidHlwZSI6NCwiaWF0IjoxNjg3MjYwMDg4LCJleHAiOjE2ODczNDY0ODh9.B3ZhO_hvFwi7kn-dMs9mwkqjibV7Vq2xex1cq1uZa2s");
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
      String? message = await RemainRepository.getRemainClocks(appointmentId);
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
      String? message = await BookNowRepository.booknow(appointmentId, token);
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
