import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_auth_event.dart';
part 'register_auth_state.dart';

class RegisterAuthBloc extends Bloc<RegisterAuthEvent, RegisterAuthState> {
  RegisterAuthBloc() : super(InitialRegisterAuthState()) {
    on<LoginEmailPassEvent>((event, emit) async {
      emit(LoadingRegisterAuthState(true));
      if (event.email == "a@a.com") {
        await Future.delayed(Duration(seconds: 3));
        emit(SuccessRegisterAuthState());
      } else {
        emit(LoadingRegisterAuthState(true));
        await Future.delayed(Duration(seconds: 3));
        emit(FailedRegisterAuthState());
      }
    });
  }
}
