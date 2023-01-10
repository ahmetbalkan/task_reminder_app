part of 'login_auth_bloc.dart';

abstract class LoginAuthState extends Equatable {
  const LoginAuthState();

  @override
  List<Object> get props => [];
}

class InitialLoginAuthState extends LoginAuthState {}

class LoadingLoginAuthState extends LoginAuthState {
  final bool isLoading;

  LoadingLoginAuthState(this.isLoading);
}

class SuccessLoginAuthState extends LoginAuthState {}

class FailedLoginAuthState extends LoginAuthState {}
