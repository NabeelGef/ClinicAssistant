// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/model/delays_and_warnings.dart';
import 'package:clinicassistant/model/remainder_notification.dart';

class NotificationState {
  RemainderNotificationState remainderNotificationstate;
  DelyasAndWarningsNotificationState delyasAndWarningsNotificationstate;
  NotificationState({
    required this.remainderNotificationstate,
    required this.delyasAndWarningsNotificationstate,
  });
}

class RemainderNotificationState {
  RemainderNotification? remainderNotification;
  String? error;
  RemainderNotificationState({
    this.remainderNotification,
    this.error,
  });
}

class DelyasAndWarningsNotificationState {
  DelaysAndWarningsNotification? delaysAndWarningsNotification;
  String? error;
  DelyasAndWarningsNotificationState({
    this.delaysAndWarningsNotification,
    this.error,
  });
}
