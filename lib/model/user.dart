
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User
{
  User(
  {
     this.id,
     this.firstName,
     this.lastName,
     this.phoneNumber,
     this.access_token,
     this.userProfilePicture

  });

  String? id ;
  String? phoneNumber;
  String? userProfilePicture;
  String? firstName;
  String? lastName;
  String? access_token;

  factory User.fromJson( Map < String , dynamic > json ) => _$UserFromJson(json);
}