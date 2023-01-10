part of 'login_check_bloc.dart';

abstract class LoginCheckEvent extends Equatable {
  const LoginCheckEvent();

  @override
  List<Object> get props => [];
}

class PasswordCheckEvent extends LoginCheckEvent {
  final String email;
  final String password;

  PasswordCheckEvent({required this.email, required this.password});

  @override
  List<Object> get props => [password];
}

class EmailCheckEvent extends LoginCheckEvent {
  final String email;
  final String password;

  EmailCheckEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email];
}

class LoginUserPassEvent extends LoginCheckEvent {
  final String email;
  final String pass;

  LoginUserPassEvent({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}
