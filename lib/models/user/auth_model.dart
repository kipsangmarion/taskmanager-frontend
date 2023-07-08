import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends Equatable {
  const AuthModel({
    this.username,
    this.password,
    this.password2,
    this.email,
    this.firstName,
    this.lastName,
  });

  final String? username;
  final String? password;
  final String? password2;
  final String? email;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return _$AuthModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  AuthModel copyWith({
    String? username,
    String? password,
    String? password2,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return AuthModel(
      username: username ?? this.username,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object?> get props {
    return [
      username,
      password,
      password2,
      email,
      firstName,
      lastName,
    ];
  }
}