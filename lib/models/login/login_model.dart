import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  const LoginModel({this.refresh, this.access});

  final String? refresh;
  final String? access;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginModel copyWith({
    String? refresh,
    String? access,
  }) {
    return LoginModel(
      refresh: refresh ?? this.refresh,
      access: access ?? this.access,
    );
  }

  @override
  List<Object?> get props => [refresh, access];
}