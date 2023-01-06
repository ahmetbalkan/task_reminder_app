part of 'loginpage_bloc.dart';

abstract class LoginpageState extends Equatable {
  String? passErrorText;
  String? emailErrorText;
  bool? isLoginComplete;
  LoginpageState(this.passErrorText, this.emailErrorText, this.isLoginComplete);
}

class LoginpageInitial extends LoginpageState {
  LoginpageInitial(
      {String? passErrorText, String? emailErrorText, bool? isLoginComplete})
      : super(passErrorText, emailErrorText, isLoginComplete);

  @override
  List<Object> get props => [passErrorText!, emailErrorText!, isLoginComplete!];
}

class ErrorTextState extends LoginpageState {
  ErrorTextState(
      {String? passErrorText, String? emailErrorText, bool? isLoginComplete})
      : super(passErrorText, emailErrorText, isLoginComplete);

  @override
  List<Object> get props => [passErrorText!, emailErrorText!, isLoginComplete!];
}
