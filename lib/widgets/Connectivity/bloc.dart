// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clinicassistant/widgets/Connectivity/event.dart';
import 'package:clinicassistant/widgets/Connectivity/state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityResult result;
  StreamSubscription? streamSubscription;
  ConnectivityBloc(
    this.result,
  ) : super(ConnectivityInitial(
            result)) {} /*{
    if (result == ConnectivityResult.none) {
      print("Not Connected Event");
      add(onNotConnected());
    } else {
      print(" Connected Event");
      add(onConnected());
    }*/

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is onConnected) {
      yield ConnectedState();
    }
    if (event is onNotConnected) {
      yield NotConnectedState();
    }
  }

  startListening() {
    print("StartListining...");
    if (result == ConnectivityResult.none) {
      print("Not Connected Event");
      add(onNotConnected());
    } else {
      print(" Connected Event");
      add(onConnected());
    }
    streamSubscription = Connectivity().onConnectivityChanged.listen((statues) {
      if (statues == ConnectivityResult.none) {
        print("Not Connected Event");
        add(onNotConnected());
      } else {
        print(" Connected Event");

        add(onConnected());
      }
    });
  }
}
