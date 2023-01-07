import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'loginpage_event.dart';
part 'loginpage_state.dart';

class LoginpageBloc extends Bloc<LoginpageEvent, LoginpageState> {
  LoginpageBloc()
      : super(LoginpageInitial(
            passErrorText: "", emailErrorText: "", isLoginComplete: false)) {
    on<PasswordCheckEvent>((event, emit) {
      if (_validatePassword(event.password) == "") {
        emit(ErrorTextState(
            passErrorText: "", emailErrorText: "", isLoginComplete: true));
      } else {
        emit(ErrorTextState(
            passErrorText: _validatePassword(event.password),
            emailErrorText: "",
            isLoginComplete: false));
      }
    });

    on<EmailCheckEvent>((event, emit) {
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(event.email)) {
        emit(ErrorTextState(
            passErrorText: "",
            emailErrorText: "Bu bir email adresi değil.",
            isLoginComplete: false));
      } else {
        emit(ErrorTextState(
            passErrorText: "", emailErrorText: "", isLoginComplete: true));
      }
    });
  }
}

String _validatePassword(String value) {
  if (!RegExp("(?=.*[a-z])").hasMatch(value)) {
    return "Password must contain at least one lowercase letter\n";
  }
  if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
    return "Password must contain at least one uppercase letter\n";
  }
  if (!RegExp((r'\d')).hasMatch(value)) {
    return "Password must contain at least one digit\n";
  }
  if (!RegExp((r'\W')).hasMatch(value)) {
    return "Password must contain at least one symbol\n";
  }
  if (value.length < 8) {
    return "Password has at least 8 characters\n";
  } else {
    return "";
  }
}

String _validateEmail(String value) {
  if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return "Bu bir email adresi değil.";
  } else {
    return "";
  }
}
