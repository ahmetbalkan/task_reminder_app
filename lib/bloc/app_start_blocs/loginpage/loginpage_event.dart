part of 'loginpage_bloc.dart';

abstract class LoginpageEvent extends Equatable {
  const LoginpageEvent();

  @override
  List<Object> get props => [];
}

class PasswordCheckEvent extends LoginpageEvent {
  final String password;

  PasswordCheckEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class EmailCheckEvent extends LoginpageEvent {
  final String email;

  EmailCheckEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginUserPassEvent extends LoginpageEvent {
  final String email;
  final String pass;

  LoginUserPassEvent({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}
