import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/view/main_page.dart';
part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  TaskIsarRepository _taskIsarRepository = TaskIsarRepository();
  TaskBloc() : super(TaskBlocInitial()) {
    on<DeleteTaskEvent>((event, emit) async {
      _taskIsarRepository.deleteUser(event.id);
    });

    on<AddTaskEvent>((event, emit) async {
      if (event.taskModel.dateTimeFinish == null) {
        emit(ErrorTextState(errorText: "Tarih seçimi yapılmadı."));
      }
      if (event.taskModel.priority == null) {
        emit(ErrorTextState(errorText: "Öncelik seçimi yapılmadı."));
      }
      if (event.taskModel.categoryid == null) {
        emit(ErrorTextState(errorText: "Kategori seçimi yapılmadı."));
      } else {
        _taskIsarRepository.saveUser(event.taskModel);
      }
    });
  }
}
