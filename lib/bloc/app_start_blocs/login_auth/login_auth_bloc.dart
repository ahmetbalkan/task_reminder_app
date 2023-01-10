import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc() : super(InitialLoginAuthState()) {
    on<LoginEmailPassEvent>((event, emit) async {
      emit(LoadingLoginAuthState());
      if (event.email == "a@a.com") {
        emit(SuccessLoginAuthState());
      } else {
        emit(FailedLoginAuthState());
      }
    });
  }
}
