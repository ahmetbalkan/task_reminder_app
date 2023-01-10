import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_reminder_app/view/login_screen.dart';

part 'login_check_event.dart';
part 'login_check_state.dart';

class LoginCheckBloc extends Bloc<LoginCheckEvent, LoginCheckState> {
  LoginCheckBloc()
      : super(LoginCheckInitial(
            passErrorText: "false",
            emailErrorText: "false",
            isEmailChecked: false,
            isPasswordChecked: false)) {
    on<LoginUserPassEvent>((event, emit) {
      if (_validateEmail(event.email) == "false") {
        if (_validatePasswordLogin(event.pass) == "false") {
          emit(ErrorTextState(
              emailErrorText: "false",
              isEmailChecked: true,
              passErrorText: "false",
              isPasswordChecked: true));
        } else {
          emit(ErrorTextState(
              emailErrorText: _validateEmail(event.email),
              isEmailChecked: false,
              passErrorText: _validatePasswordLogin(event.pass),
              isPasswordChecked: false));
        }
      } else {
        emit(ErrorTextState(
            emailErrorText: _validateEmail(event.email),
            isEmailChecked: false,
            passErrorText: _validatePasswordLogin(event.pass),
            isPasswordChecked: false));
      }
    });
  }
}

/* emit(ErrorTextState(
          passErrorText: null,
          emailErrorText: null,
          isEmailChecked: true,
          isPasswordChecked: true));*/

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
  if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{8,20}$')
      .hasMatch(value)) {
    return "Şifreniz en az 8 haneli Harf, Sayı, Sembollerden oluşmalı.";
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
