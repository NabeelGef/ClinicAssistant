import 'package:clinicassistant/model/worktime.dart';
import 'package:clinicassistant/model/worktimeclock.dart';
import 'package:clinicassistant/repository/BookRepository/book_now_repo.dart';
import 'package:clinicassistant/repository/BookRepository/clock_time_repo.dart';
import 'package:clinicassistant/repository/BookRepository/remain_repo.dart';
import 'package:clinicassistant/repository/BookRepository/work_time_repo.dart';
import 'package:dio/dio.dart';
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
      yield* LoadingClocks(event.workTimeId, event.token);
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
    if (event is LoadingEventAlertBookFilter) {
      yield* LoadingFilters(event.doctorId, event.clinicId, event.doctorId,
          event.token, event.month, event.year);
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
      if (e is DioException) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          yield StateAlertBook(
              successAlertBookClock: state.successAlertBookClock,
              successAlertBook:
                  SuccessAlertBook(workTime: null, error: "Not Found"));
        } else {
          yield StateAlertBook(
              successAlertBookClock: state.successAlertBookClock,
              successAlertBook: SuccessAlertBook(
                  workTime: null, error: "Not Found any data"));
        }
      }
    }
  }

  Stream<StateAlertBook> LoadingClocks(String workTimeId, String token) async* {
    yield StateAlertBook(
        successAlertBookClock:
            SuccessAlertBookClock(workTimeClock: null, error: ""),
        successAlertBook: state.successAlertBook);
    try {
      WorkTimeClock? workTimeClock =
          await ClockTimeRepository.getWorkTimeClocks(workTimeId, token);
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
      if (e is DioException) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          print("Here");
          yield StateAlertBook(
              successAlertBookClock: SuccessAlertBookClock(
                  workTimeClock: null, error: "Not Found"),
              successAlertBook: state.successAlertBook);
        } else {
          yield StateAlertBook(
              successAlertBookClock: SuccessAlertBookClock(
                  workTimeClock: null, error: "Not Found any data"),
              successAlertBook: state.successAlertBook);
        }
      }
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

  Stream<StateAlertBook> LoadingFilters(String doctorId, String clinicId,
      String doctorId2, String token, String month, String year) async* {
    yield StateAlertBook(
        successAlertBookClock: state.successAlertBookClock,
        successAlertBook: SuccessAlertBook(workTime: null, error: ""));
    try {
      WorkTime? workTime = await WorkTimeRepository.getWorkTimeFilter(
          doctorId, clinicId, token, month, year);
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
      print("Error In WorkTimes Filters is : $e ,in $s");
      if (e is DioException) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          yield StateAlertBook(
              successAlertBookClock: state.successAlertBookClock,
              successAlertBook:
                  SuccessAlertBook(workTime: null, error: "Not Found"));
        } else {
          yield StateAlertBook(
              successAlertBookClock: state.successAlertBookClock,
              successAlertBook: SuccessAlertBook(
                  workTime: null, error: "Not Found any data"));
        }
      }
    }
  }
}

class TimeBloc extends Bloc<DateEvent, TimeState> {
  TimeBloc(super.initialState);

  @override
  Stream<TimeState> mapEventToState(DateEvent event) async* {
    if (event is SelectedMonthEvent) {
      yield TimeState(MonthState(selecteMonth: event.month),
          YearState(selecteYear: state.yearState.selecteYear));
    }
    if (event is SelectedYearEvent) {
      yield TimeState(MonthState(selecteMonth: state.monthState.selecteMonth),
          YearState(selecteYear: event.year));
    }
  }
}
