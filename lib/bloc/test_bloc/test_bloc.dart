import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_reminder_app/model/task.dart';

import '../../locator.dart';
import '../../repository/task_isar_repository.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  var _taskIsarRepository = locator.get<TaskIsarRepository>();

  TestBloc() : super(TestInitial()) {
    on<GetAllTaskEvent>(_getAllTask);
    on<GetCompleteTaskEvent>(_getCompleteTask);
    on<GetTodayTaskEvent>(_getTodayTask);
    on<GetSearchTaskEvent>(_getSearchTask);
  }
  _getCompleteTask(GetCompleteTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetAllTaskState(
        allTask: await _taskIsarRepository.getCompleteTask(),
        name: "Complete Task"));
  }

  _getAllTask(GetAllTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetAllTaskState(
        allTask: await _taskIsarRepository.getAllTask(), name: "All Task"));
  }

  _getTodayTask(GetTodayTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetAllTaskState(
        allTask: await _taskIsarRepository.getTodayTask(), name: "Bugün"));
  }

  _getSearchTask(GetSearchTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetAllTaskState(
        allTask: await _taskIsarRepository.searchTask(event.seachValue),
        name: "Aranan İçerik:"));
  }
}
