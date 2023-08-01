import 'dart:io';

abstract class PersonalProfileEvents {
  const PersonalProfileEvents();
}

class LoadingPersonalProfile extends PersonalProfileEvents {
  String token;
  LoadingPersonalProfile({required this.token});
}

class EditImageProfile extends PersonalProfileEvents {
  File? image;
  String token;
  EditImageProfile({required this.image, required this.token});
}
