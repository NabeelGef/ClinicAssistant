import 'package:clinicassistant/Screen/doctorsPage/all_doctors_page.dart';
import 'package:clinicassistant/Screen/homePage/home.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom0.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom4.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome1.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome2.dart';
import 'package:clinicassistant/Screen/welcomePage/welcome3.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RouterNav{
  static FluroRouter fluroRouter = FluroRouter();
  static Handler welcome0 = Handler(
      handlerFunc: (context, parameters) {
    return Welcome0();
  });
  static Handler welcome1 = Handler(
      handlerFunc: (context, parameters) {
        return Welcome1();
      });
  static Handler welcome2 = Handler(
      handlerFunc: (context, parameters) {
        return Welcome2();
      });
  static Handler welcome3 = Handler(
      handlerFunc: (context, parameters) {
        return Welcome3();
      });
  static Handler welcome4 = Handler(
      handlerFunc: (context, parameters) {
        return Welcome4();
      });
  static Handler home = Handler(
      handlerFunc: (context, parameters) {
        return Home();
      });
  static Handler alldoctors = Handler(
      handlerFunc: (context, parameters) {
        return AllDoctors();
      });

  static void setupRouter() {
  fluroRouter.define("/", handler: welcome0 , transitionType: TransitionType.fadeIn);
  fluroRouter.define("/welcome1", handler: welcome1 , transitionType: TransitionType.inFromRight);
  fluroRouter.define("/welcome2", handler: welcome2 , transitionType: TransitionType.inFromRight);
  fluroRouter.define("/welcome3", handler: welcome3 , transitionType: TransitionType.inFromRight);
  fluroRouter.define("/welcome4", handler: welcome4 , transitionType: TransitionType.inFromRight);
  fluroRouter.define("/home", handler: home , transitionType: TransitionType.inFromRight);
  fluroRouter.define("/home/alldoctors", handler: alldoctors ,transitionType: TransitionType.nativeModal);

  }
  }