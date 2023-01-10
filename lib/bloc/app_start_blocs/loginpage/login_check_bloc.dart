import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
        if (_validatePassword(event.pass) == "false") {
          emit(ErrorTextState(
              emailErrorText: "false",
              isEmailChecked: true,
              passErrorText: "false",
              isPasswordChecked: true));
        } else {
          emit(ErrorTextState(
              emailErrorText: _validateEmail(event.email),
              isEmailChecked: false,
              passErrorText: _validatePassword(event.pass),
              isPasswordChecked: false));
        }
      } else {
        emit(ErrorTextState(
            emailErrorText: _validateEmail(event.email),
            isEmailChecked: false,
            passErrorText: _validatePassword(event.pass),
            isPasswordChecked: false));
      }
    });
  }
}

String _validatePassword(String value) {
  if (!RegExp("(?=.*[a-zA-Z])").hasMatch(value)) {
    return "lowercasedesc".tr();
  }
  if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
    return "uppercasedesc".tr();
  }
  if (!RegExp((r'\d')).hasMatch(value)) {
    return "digitsec".tr();
  }
  if (value.length < 8) {
    return "8digit".tr();
  } else {
    return "false";
  }
}

String _validateEmail(String value) {
  if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return "mailerror".tr();
  } else {
    return "false";
  }
}
