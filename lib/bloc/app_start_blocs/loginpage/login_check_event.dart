part of 'login_check_bloc.dart';

abstract class LoginCheckEvent extends Equatable {
  const LoginCheckEvent();

  @override
  List<Object> get props => [];
}

class LoginUserPassEvent extends LoginCheckEvent {
  final String email;
  final String pass;

  LoginUserPassEvent({required this.email, required this.pass});

  @override
  List<Object> get props => [email, pass];
}
