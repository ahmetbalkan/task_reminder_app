import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'intropage_event.dart';
part 'intropage_state.dart';

class IntroPageBloc extends Bloc<IntroPageEvent, IntroPageState> {
  IntroPageBloc() : super(const IntropageInitial(ilkdeger: 0)) {
    on<SetIntroCountEvent>((event, emit) {
      emit(IntropageInitial(ilkdeger: event.setCount));
    });
  }
}
