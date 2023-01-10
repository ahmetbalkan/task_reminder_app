part of 'register_auth_bloc.dart';

abstract class RegisterAuthState extends Equatable {
  const RegisterAuthState();

  @override
  List<Object> get props => [];
}

class InitialRegisterAuthState extends RegisterAuthState {}

class LoadingRegisterAuthState extends RegisterAuthState {
  final bool isLoading;

  LoadingRegisterAuthState(this.isLoading);
}

class SuccessRegisterAuthState extends RegisterAuthState {}

class FailedRegisterAuthState extends RegisterAuthState {}
