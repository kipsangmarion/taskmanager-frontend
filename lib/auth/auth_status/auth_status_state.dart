part of 'auth_status_bloc.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusInitial extends AuthStatusState {}

class AuthStatusLoading extends AuthStatusState {}

class AuthStatusSuccess extends AuthStatusState {}

class AuthStatusLoggedOut extends AuthStatusState {}