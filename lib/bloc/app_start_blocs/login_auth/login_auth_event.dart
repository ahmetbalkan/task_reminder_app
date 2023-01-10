part of 'login_auth_bloc.dart';

abstract class LoginAuthEvent extends Equatable {
  const LoginAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailPassEvent extends LoginAuthEvent {
  final String email;
  final String password;

  const LoginEmailPassEvent({required this.email, required this.password});
}

class LoginGooglePassEvent extends LoginAuthEvent {}

class LoginApplePassEvent extends LoginAuthEvent {}
