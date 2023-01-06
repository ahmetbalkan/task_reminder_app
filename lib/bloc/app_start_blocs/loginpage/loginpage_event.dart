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
