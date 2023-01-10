part of 'login_check_bloc.dart';

abstract class LoginCheckState extends Equatable {
  String? passErrorText;
  String? emailErrorText;
  bool? isEmailChecked;
  bool? isPasswordChecked;
  LoginCheckState(this.passErrorText, this.emailErrorText, this.isEmailChecked,
      this.isPasswordChecked);
}

class LoginCheckInitial extends LoginCheckState {
  LoginCheckInitial(
      {String? passErrorText,
      String? emailErrorText,
      bool? isEmailChecked,
      bool? isPasswordChecked})
      : super(passErrorText, emailErrorText, isEmailChecked, isPasswordChecked);

  @override
  List<Object> get props =>
      [passErrorText!, emailErrorText!, isEmailChecked!, isPasswordChecked!];
}

class ErrorTextState extends LoginCheckState {
  ErrorTextState(
      {String? passErrorText,
      String? emailErrorText,
      bool? isEmailChecked,
      bool? isPasswordChecked})
      : super(passErrorText, emailErrorText, isEmailChecked, isPasswordChecked);

  @override
  List<Object> get props =>
      [passErrorText!, emailErrorText!, isEmailChecked!, isPasswordChecked!];
}
