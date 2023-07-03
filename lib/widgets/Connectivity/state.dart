import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {
  final ConnectivityResult result;
  ConnectivityInitial(this.result);
}

class ConnectedState extends ConnectivityState {}

class NotConnectedState extends ConnectivityState {}
