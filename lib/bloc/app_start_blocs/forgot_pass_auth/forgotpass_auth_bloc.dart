import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forgotpass_auth_event.dart';
part 'forgotpass_auth_state.dart';

class ForgotPassAuthBloc
    extends Bloc<ForgotPassAuthEvent, ForgotPassAuthState> {
  ForgotPassAuthBloc() : super(InitialForgotPassAuthState()) {
    on<ForgotPassEmailEvent>((event, emit) async {
      emit(LoadingForgotPassAuthState(true));
      if (event.email == "a@a.com") {
        await Future.delayed(Duration(seconds: 3));
        emit(SuccessForgotPassAuthState());
      } else {
        emit(LoadingForgotPassAuthState(true));
        await Future.delayed(Duration(seconds: 3));
        emit(FailedForgotPassAuthState());
      }
    });
  }
}
