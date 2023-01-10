import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc() : super(InitialLoginAuthState()) {
    on<LoginEmailPassEvent>((event, emit) async {
      emit(LoadingLoginAuthState(true));
      if (event.email == "a@a.com") {
        await Future.delayed(Duration(seconds: 3));
        emit(SuccessLoginAuthState());
      } else {
        emit(LoadingLoginAuthState(true));
        await Future.delayed(Duration(seconds: 3));
        emit(FailedLoginAuthState());
      }
    });
  }
}
