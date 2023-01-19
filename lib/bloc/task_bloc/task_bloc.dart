import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/view/main_page.dart';

import '../../locator.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  var _taskIsarRepository = locator.get<TaskIsarRepository>();
  TaskBloc() : super(TaskBlocState()) {
    on<AddTaskEvent>(_addTask);
    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<GetTaskEvent>(_getTaskEvent);
  }

  _addTask(AddTaskEvent event, Emitter<TaskBlocState> emit) {
    print(event.taskModel.categoryid);
    print(event.taskModel.priority);
    print(event.taskModel.dateTimeFinish);
    if (event.taskModel.dateTimeFinish == null) {
      emit(state.copyWith(
          errorText: "Tarih Boş", postStatus: PostStatus.failure));
    } else if (event.taskModel.categoryid == null) {
      emit(state.copyWith(
          errorText: "Category Boş", postStatus: PostStatus.failure));
    } else if (event.taskModel.priority == null) {
      emit(state.copyWith(
          errorText: "Öncelik Sırası Boş", postStatus: PostStatus.failure));
    } else {
      _taskIsarRepository.saveUser(event.taskModel);
      emit(state.copyWith(errorText: "", postStatus: PostStatus.success));
    }
  }

  _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskBlocState> emit) {
    _taskIsarRepository.deleteUser(event.id);
  }

  _getTaskEvent(GetTaskEvent event, Emitter<TaskBlocState> emit) async {
    if (event.getTaskStatus == GetTaskStatus.all) {
      emit(state.copyWith(
          getTaskStatus: GetTaskStatus.all,
          tasks: await _taskIsarRepository.getAllTask()));
    }
    if (event.getTaskStatus == GetTaskStatus.complete) {
      var a = await _taskIsarRepository.getCompleteTask();
      emit(state.copyWith(
          getTaskStatus: GetTaskStatus.complete, tasks: state.tasks));
    }
  }
}
