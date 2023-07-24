
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends Equatable {
  const UserProfileModel(
      {this.id,
      this.username,
      this.lastName,
      this.firstName,
      this.user_id,
      this.intro,
      this.image});

  final int? id;
  final int? user_id;
  final String? intro;
  final String? image;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? username;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return _$UserProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  UserProfileModel copyWith(
      {int? id,
      int? user_id,
      String? username,
      String? firstName,
      String? lastName,
      String? intro,
      String? image}) {
    return UserProfileModel(
      id: id ?? this.id,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      user_id: user_id ?? this.user_id,
      intro: intro ?? this.intro,
      image: image ?? this.image,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props =>
      [id, user_id, intro, image, firstName, lastName, username];
}
