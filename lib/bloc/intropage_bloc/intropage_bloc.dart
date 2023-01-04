import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'intropage_event.dart';
part 'intropage_state.dart';

class IntropageBloc extends Bloc<IntropageEvent, IntropageState> {
  IntropageBloc() : super(IntropageInitial(ilkdeger: 0)) {
    on<SetIntroCountEvent>((event, emit) {
      emit(IntropageInitial(ilkdeger: event.setCount));
    });
  }
}
