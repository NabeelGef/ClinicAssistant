// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class CancleEvent {
  CancleEvent();
}

class LoadingDataCancle extends CancleEvent {
  final String Id;
  final String token;
  LoadingDataCancle({
    required this.Id,
    required this.token,
  });
}
class Cancling extends CancleEvent{
  final String Id;
  final String token;
  Cancling({required this.Id,required this.token});
}
