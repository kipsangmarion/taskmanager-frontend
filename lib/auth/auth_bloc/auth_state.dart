part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthLogoutSuccess extends AuthState {}
class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  const AuthError(this.errorMessage);
  final String? errorMessage;
}