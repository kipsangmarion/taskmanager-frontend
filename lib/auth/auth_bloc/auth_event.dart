part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  const RegisterUserEvent(this.authModel);

  final AuthModel? authModel;
}

class LoginUserEvent extends AuthEvent {
  const LoginUserEvent(this.authModel);

  final AuthModel? authModel;
}
class LogoutUserEvent extends AuthEvent {}
