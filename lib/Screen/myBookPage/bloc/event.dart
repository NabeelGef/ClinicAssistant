class MyBookEvent {
  MyBookEvent();
}

class LoadingMyCurrentAppointment extends MyBookEvent {
  final token;

  LoadingMyCurrentAppointment(this.token);
}

class LoadingMyPreviousAppointment extends MyBookEvent {
  final token;

  LoadingMyPreviousAppointment(this.token);
}
