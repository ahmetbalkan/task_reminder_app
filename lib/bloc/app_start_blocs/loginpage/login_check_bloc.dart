import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_check_event.dart';
part 'login_check_state.dart';

class LoginCheckBloc extends Bloc<LoginCheckEvent, LoginCheckState> {
  LoginCheckBloc()
      : super(LoginCheckInitial(
            passErrorText: "",
            emailErrorText: "",
            isEmailChecked: false,
            isPasswordChecked: false)) {
    on<PasswordCheckEvent>((event, emit) {
      if (_validatePassword(event.password) == "false") {
        emit(ErrorTextState(
            passErrorText: "",
            emailErrorText: "",
            isEmailChecked: _validateEmail(event.password) == "" ? true : false,
            isPasswordChecked: true));
      } else {
        emit(ErrorTextState(
            passErrorText: _validatePassword(event.password),
            emailErrorText: "",
            isEmailChecked: false,
            isPasswordChecked: false));
      }
    });

    on<EmailCheckEvent>((event, emit) {
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(event.email)) {
        emit(ErrorTextState(
            passErrorText: "",
            emailErrorText: "Bu bir email adresi değil.",
            isEmailChecked: false,
            isPasswordChecked: false));
      } else {
        emit(ErrorTextState(
            passErrorText: "",
            emailErrorText: "",
            isEmailChecked: true,
            isPasswordChecked:
                _validatePassword(event.email) == "" ? true : false));
      }
    });

    on<LoginUserPassEvent>((event, emit) {
      emit(ErrorTextState(
          passErrorText: _validateEmail(event.email),
          emailErrorText: _validateEmail(event.email),
          isEmailChecked: _validateEmail(event.email) == "false" ? true : false,
          isPasswordChecked:
              _validatePassword(event.email) == "false" ? true : false));
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
    return "false";
  }
}

String _validatePasswordLogin(String value) {
  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value)) {
    return "Check your password.";
  } else {
    return "false";
  }
}

String _validateEmail(String value) {
  if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return "Bu bir email adresi değil.";
  } else {
    return "false";
  }
}
