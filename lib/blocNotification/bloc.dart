import 'package:clinicassistant/blocNotification/event.dart';
import 'package:clinicassistant/blocNotification/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSocketBloc
    extends Bloc<NotificationSockentEvent, NotificationSocketState> {
  NotificationSocketBloc(super.initialState);

  @override
  Stream<NotificationSocketState> mapEventToState(
      NotificationSockentEvent event) async* {
    if (event is AddNumberOfUnReadNotificationEvent) {
      yield NotificationSocketState(
          getNumberOfUnReadState: GetNumberOfUnReadState(num: event.num));
    }
  }
}
