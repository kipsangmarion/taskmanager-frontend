// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      user_id: json['user_id'] as int?,
      intro: json['intro'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'intro': instance.intro,
      'image': instance.image,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'username': instance.username,
    };
