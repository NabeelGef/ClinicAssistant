// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class AlertBookEvent {
  AlertBookEvent();
}

class LoadingEventAlertBook extends AlertBookEvent {
  final String doctorId;
  final String clinicId;
  final String token;

  LoadingEventAlertBook({
    required this.doctorId,
    required this.clinicId,
    required this.token,
  });
}

class LoadingEventAlertBookFilter extends AlertBookEvent {
  final String doctorId;
  final String clinicId;
  final String token;
  final String month;
  final String year;
  LoadingEventAlertBookFilter(
      this.doctorId, this.clinicId, this.token, this.month, this.year);
}

class DateEvent {
  DateEvent();
}

class SelectedYearEvent extends DateEvent {
  int year;
  SelectedYearEvent({
    required this.year,
  });
}

class SelectedMonthEvent extends DateEvent {
  int month;
  SelectedMonthEvent({
    required this.month,
  });
}

class LoadingEventAlertBookClock extends AlertBookEvent {
  final String token;
  final String workTimeId;
  LoadingEventAlertBookClock(this.workTimeId, this.token);
}

class SelectTime extends AlertBookEvent {
  final List<Map<int, bool>> selected;
  final int index;
  SelectTime(this.index, this.selected);
}

class LoadingEventRemaining extends AlertBookEvent {
  final String appointmentId;
  LoadingEventRemaining(this.appointmentId);
}

class BookNowEvent extends AlertBookEvent {
  final String token;
  final String appointmentId;
  BookNowEvent(this.token, this.appointmentId);
}
