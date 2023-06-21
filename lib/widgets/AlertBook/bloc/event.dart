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

class LoadingEventAlertBookClock extends AlertBookEvent {
  final String workTimeId;
  LoadingEventAlertBookClock(this.workTimeId);
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
