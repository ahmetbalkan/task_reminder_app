part of 'register_auth_bloc.dart';

abstract class RegisterAuthEvent extends Equatable {
  const RegisterAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailPassEvent extends RegisterAuthEvent {
  final String email;
  final String password;

  const LoginEmailPassEvent({required this.email, required this.password});
}

class LoginGooglePassEvent extends RegisterAuthEvent {}

class LoginApplePassEvent extends RegisterAuthEvent {}
