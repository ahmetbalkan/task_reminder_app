part of 'login_check_bloc.dart';

abstract class LoginCheckState extends Equatable {
  String? passErrorText;
  String? emailErrorText;
  bool? isLoginComplete;
  LoginCheckState(
      this.passErrorText, this.emailErrorText, this.isLoginComplete);
}

class LoginCheckInitial extends LoginCheckState {
  LoginCheckInitial(
      {String? passErrorText, String? emailErrorText, bool? isLoginComplete})
      : super(passErrorText, emailErrorText, isLoginComplete);

  @override
  List<Object> get props => [passErrorText!, emailErrorText!, isLoginComplete!];
}

class ErrorTextState extends LoginCheckState {
  ErrorTextState(
      {String? passErrorText, String? emailErrorText, bool? isLoginComplete})
      : super(passErrorText, emailErrorText, isLoginComplete);

  @override
  List<Object> get props => [passErrorText!, emailErrorText!, isLoginComplete!];
}
