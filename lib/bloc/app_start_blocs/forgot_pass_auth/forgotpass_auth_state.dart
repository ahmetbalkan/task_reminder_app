part of 'forgotpass_auth_bloc.dart';

abstract class ForgotPassAuthState extends Equatable {
  const ForgotPassAuthState();

  @override
  List<Object> get props => [];
}

class InitialForgotPassAuthState extends ForgotPassAuthState {}

class LoadingForgotPassAuthState extends ForgotPassAuthState {
  final bool isLoading;

  LoadingForgotPassAuthState(this.isLoading);
}

class SuccessForgotPassAuthState extends ForgotPassAuthState {}

class FailedForgotPassAuthState extends ForgotPassAuthState {}
