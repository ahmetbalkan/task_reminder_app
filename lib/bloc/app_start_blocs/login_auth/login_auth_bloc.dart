import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc() : super(InitialAuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingAuthState());
      if (event.email == "a@a.com") {
        emit(SuccessAuthState());
      } else {
        emit(FailedAuthState());
      }
    });
  }
}
