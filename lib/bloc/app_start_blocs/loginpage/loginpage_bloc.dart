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
      emit(ErrorTextState(
          passErrorText: _validatePassword(event.password),
          emailErrorText: "",
          isLoginComplete: false));
    });
  }
}

String _validatePassword(String value) {
  if (!RegExp("(?=.*[a-z])").hasMatch(value!)) {
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

bool _validateEmail(String value) {
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
