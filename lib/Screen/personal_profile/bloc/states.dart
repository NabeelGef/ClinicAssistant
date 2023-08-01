
import 'dart:io';

import 'package:clinicassistant/model/personl_information.dart';

/*
abstract class PersonalProfileStates
{
  PersonalProfileStates();
}
*/

class PersonalProfileStates  {
  GetAccount getAccount;
  GetNewImage getNewImage;
  PersonalProfileStates({required this.getAccount , required this.getNewImage});
}
class GetAccount {
  final Patient? personalInformation;
  final String? error;
  GetAccount({this.personalInformation, this.error});
}
class GetNewImage{
  File? image;
  GetNewImage({this.image});
}
