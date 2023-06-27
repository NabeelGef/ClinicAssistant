// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clinicassistant/model/worktime.dart';

import '../../../model/worktimeclock.dart';

class StateAlertBook {
  SuccessAlertBook? successAlertBook;
  SuccessAlertBookClock? successAlertBookClock;
  SelectState? selectState;
  SuccessRemain? successRemain;
  SuccessBook? successBook;

  StateAlertBook(
      {this.successAlertBook,
      this.successAlertBookClock,
      this.selectState,
      this.successRemain,
      this.successBook});
}

class SuccessBook {
  String? message;
  String error;
  SuccessBook({
    this.message,
    required this.error,
  });
}

class SuccessAlertBook {
  final WorkTime? workTime;
  final String error;
  SuccessAlertBook({
    required this.workTime,
    required this.error,
  });
}

class SuccessAlertBookClock {
  final WorkTimeClock? workTimeClock;
  final String error;
  SuccessAlertBookClock({
    this.workTimeClock,
    required this.error,
  });
}

class SelectState {
  List<Map<int, bool>> selected;
  final myIndex;
  SelectState({
    this.myIndex,
    required this.selected,
  });
}

class SuccessRemain {
  String? message;
  String error;
  SuccessRemain({
    this.message,
    required this.error,
  });

  SuccessRemain copyWith({
    String? message,
    String? error,
  }) {
    return SuccessRemain(
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class TimeState {
  MonthState monthState;
  YearState yearState;
  TimeState(
    this.monthState,
    this.yearState,
  );
}

class MonthState {
  int selecteMonth;
  MonthState({
    required this.selecteMonth,
  });
}

class YearState {
  int selecteYear;
  YearState({
    required this.selecteYear,
  });
}
