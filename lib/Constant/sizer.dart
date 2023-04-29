import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';

class Sizer{

  //This is width of Screen
  static getWidth(BuildContext context){
    //print("Width = : ${MediaQuery.of(context).size.width}");
    return MediaQuery.of(context).size.width;
  }

  //This is height of Screen

  static getHeight(BuildContext context){
    //print("Height = : ${MediaQuery.of(context).size.height}");
    return MediaQuery.of(context).size.height;
  }

  //This is size of fontSize of Screen

  static getTextSize(BuildContext context , double size){
    return MediaQuery.of(context).size.width*size;
  }

  /*static String getDeviceType(BuildContext context) {
    // DeviceType.phone;
    // final data = MediaQuery.of(context).size.width;
    // print("Width = $data");
    // return data < 800 ? 'phone' :'tablet';
    final data = MediaQuery.of(context);
    print("Data = ${data.size.width}");
    return data.size.width < 400 ? 'phone' :'tablet';

  }*/
}