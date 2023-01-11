import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBlocBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  TaskBlocBloc() : super(TaskBlocInitial()) {
    on<TaskBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
