part of 'login_auth_bloc.dart';

abstract class LoginAuthEvent extends Equatable {
  const LoginAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends LoginAuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}
