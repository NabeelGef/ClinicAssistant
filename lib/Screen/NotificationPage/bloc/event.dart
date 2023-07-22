// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationEvent {}

class LoadingRemainderNotification extends NotificationEvent {
  String token;
  LoadingRemainderNotification({
    required this.token,
  });
}

class LoadingDelaysAndWraningsEvent extends NotificationEvent {
  String token;
  LoadingDelaysAndWraningsEvent({
    required this.token,
  });
}
