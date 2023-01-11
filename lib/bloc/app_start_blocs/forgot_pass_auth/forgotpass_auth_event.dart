part of 'forgotpass_auth_bloc.dart';

abstract class ForgotPassAuthEvent extends Equatable {
  const ForgotPassAuthEvent();

  @override
  List<Object> get props => [];
}

class ForgotPassEmailEvent extends ForgotPassAuthEvent {
  final String email;

  const ForgotPassEmailEvent({required this.email});
}

class ForgotPassGooglePassEvent extends ForgotPassAuthEvent {}

class ForgotPassApplePassEvent extends ForgotPassAuthEvent {}
