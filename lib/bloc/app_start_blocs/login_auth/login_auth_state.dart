part of 'login_auth_bloc.dart';

abstract class LoginAuthState extends Equatable {
  const LoginAuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends LoginAuthState {}

class LoadingAuthState extends LoginAuthState {}

class SuccessAuthState extends LoginAuthState {}

class FailedAuthState extends LoginAuthState {}
