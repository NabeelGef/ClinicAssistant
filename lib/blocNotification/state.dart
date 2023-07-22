// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationSocketState {
  GetNumberOfUnReadState getNumberOfUnReadState;
  NotificationSocketState({
    required this.getNumberOfUnReadState,
  });
}

class GetNumberOfUnReadState {
  int num;
  GetNumberOfUnReadState({
    required this.num,
  });
}
