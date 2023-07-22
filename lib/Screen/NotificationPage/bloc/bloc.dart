import 'package:clinicassistant/Screen/NotificationPage/bloc/event.dart';
import 'package:clinicassistant/Screen/NotificationPage/bloc/state.dart';
import 'package:clinicassistant/model/delays_and_warnings.dart';
import 'package:clinicassistant/model/remainder_notification.dart';
import 'package:clinicassistant/repository/notificationRepo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(super.initialState);
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadingRemainderNotification) {
      yield* loadingRemainder(event.token);
    }
    if (event is LoadingDelaysAndWraningsEvent) {
      yield* loadingDelaysAndWranings(event.token);
    }
  }

  Stream<NotificationState> loadingRemainder(String token) async* {
    yield NotificationState(
        remainderNotificationstate:
            RemainderNotificationState(remainderNotification: null, error: ""),
        delyasAndWarningsNotificationstate:
            state.delyasAndWarningsNotificationstate);

    try {
      RemainderNotification? remainderNotification =
          await NotificationRepo.RemainderNotify(token);
      if (remainderNotification == null) {
        yield NotificationState(
            remainderNotificationstate: RemainderNotificationState(
                remainderNotification: null, error: "Not Found Any Data"),
            delyasAndWarningsNotificationstate:
                state.delyasAndWarningsNotificationstate);
      } else {
        yield NotificationState(
            remainderNotificationstate: RemainderNotificationState(
                remainderNotification: remainderNotification, error: ""),
            delyasAndWarningsNotificationstate:
                state.delyasAndWarningsNotificationstate);
      }
    } catch (e, stack) {
      print("Error In Notification Remainder $e in $stack");
      if (e is DioException) {
        if (e.response!.statusCode == 404) {
          yield NotificationState(
              remainderNotificationstate: RemainderNotificationState(
                  remainderNotification: null, error: "Not Found"),
              delyasAndWarningsNotificationstate:
                  state.delyasAndWarningsNotificationstate);
        }
      }
      yield NotificationState(
          remainderNotificationstate: RemainderNotificationState(
              remainderNotification: null, error: "Not Found Any Data"),
          delyasAndWarningsNotificationstate:
              state.delyasAndWarningsNotificationstate);
    }
  }

  Stream<NotificationState> loadingDelaysAndWranings(String token) async* {
    yield NotificationState(
        remainderNotificationstate: state.remainderNotificationstate,
        delyasAndWarningsNotificationstate: DelyasAndWarningsNotificationState(
            delaysAndWarningsNotification: null, error: ""));
    try {
      DelaysAndWarningsNotification? delaysAndWarningsNotification =
          await NotificationRepo.DelaysAndWarningsNotify(token);
      if (delaysAndWarningsNotification == null) {
        yield NotificationState(
            remainderNotificationstate: state.remainderNotificationstate,
            delyasAndWarningsNotificationstate:
                DelyasAndWarningsNotificationState(
                    delaysAndWarningsNotification: null,
                    error: "Not Found Any Data"));
      } else {
        yield NotificationState(
            remainderNotificationstate: state.remainderNotificationstate,
            delyasAndWarningsNotificationstate:
                DelyasAndWarningsNotificationState(
                    delaysAndWarningsNotification:
                        delaysAndWarningsNotification,
                    error: ""));
      }
    } catch (e, stack) {
      print("Error in Notification Delays And Warnings $e in $stack");
      if (e is DioException) {
        if (e.response!.statusCode == 404) {
          yield NotificationState(
              remainderNotificationstate: state.remainderNotificationstate,
              delyasAndWarningsNotificationstate:
                  DelyasAndWarningsNotificationState(
                      delaysAndWarningsNotification: null, error: "Not Found"));
        }
      }
      yield NotificationState(
          remainderNotificationstate: state.remainderNotificationstate,
          delyasAndWarningsNotificationstate:
              DelyasAndWarningsNotificationState(
                  delaysAndWarningsNotification: null,
                  error: "Not Found Any Data"));
    }
  }
}
