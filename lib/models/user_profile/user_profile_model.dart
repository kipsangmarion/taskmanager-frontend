import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends Equatable {
  const UserProfileModel({this.id, this.user, this.intro, this.image});

  final int? id;
  final int? user;
  final String? intro;
  final String? image;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return _$UserProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfileModel copyWith({
    int? id,
    int? user,
    String? intro,
    String? image
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      user: user ?? this.user,
      intro: intro ?? this.intro,
      image: image?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, user, intro, image];
}