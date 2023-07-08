// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      username: json['username'] as String?,
      password: json['password'] as String?,
      password2: json['password2'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'password2': instance.password2,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
