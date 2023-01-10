part of 'login_auth_bloc.dart';

abstract class LoginAuthState extends Equatable {
  const LoginAuthState();

  @override
  List<Object> get props => [];
}

class InitialLoginAuthState extends LoginAuthState {}

class LoadingLoginAuthState extends LoginAuthState {}

class SuccessLoginAuthState extends LoginAuthState {}

class FailedLoginAuthState extends LoginAuthState {}
