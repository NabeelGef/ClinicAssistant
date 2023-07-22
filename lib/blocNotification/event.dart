// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationSockentEvent {}

class AddNumberOfUnReadNotificationEvent extends NotificationSockentEvent {
  int num;
  AddNumberOfUnReadNotificationEvent({
    required this.num,
  });
}
