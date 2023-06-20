// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
 try {
       return User(
             id: json['id'] as String?,
             firstName: json['firstName'] as String?,
             lastName: json['lastName'] as String?,
             phoneNumber: json['phoneNumber'] as String?,
             access_token: json['access_token'] as String?,
             userProfilePicture: json['userProfilePicture'] as String?,
       );
 }catch(e){
       print("=========error:========");
       throw Exception(e);
}

      Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
            'id': instance.id,
            'phoneNumber': instance.phoneNumber,
            'userProfilePicture': instance.userProfilePicture,
            'firstName': instance.firstName,
            'lastName': instance.lastName,
            'access_token': instance.access_token,
      };
}
