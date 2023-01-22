import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';

import '../../locator.dart';
import '../../repository/task_isar_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  var _taskIsarRepository = locator.get<TaskIsarRepository>();
  var _categoryIsarRepository = locator.get<CategoryIsarRepository>();

  TestBloc() : super(TestInitial()) {
    on<GetAllTaskEvent>(_getAllTask);
    on<AddTestEvent>(_addTask);
    on<GetCompleteTaskEvent>(_getCompleteTask);
    on<GetTodayTaskEvent>(_getTodayTask);
    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<EditTestEvent>(_editTaskEvent);
    on<UpdateTestEvent>(_updateTestEvent);
  }

  _getCompleteTask(GetCompleteTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetCompleteTaskState(event.seachValue));
  }

  _getAllTask(GetAllTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetAllTaskState(event.seachValue));
  }

  _getTodayTask(GetTodayTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    emit(GetTodayTaskState((event.seachValue)));
  }

  _deleteTaskEvent(DeleteTaskEvent event, Emitter<TestState> emit) async {
    emit(TestInitial());
    await _taskIsarRepository.deleteUser(event.id);
  }

  _addTask(AddTestEvent event, Emitter<TestState> emit) {
    _taskIsarRepository.saveUser(event.taskModel);
    emit(AddSuccessState());
  }

  _editTaskEvent(EditTestEvent event, Emitter<TestState> emit) {
    emit(EditTestState(updateTask: event.taskModel));
  }

  _updateTestEvent(UpdateTestEvent event, Emitter<TestState> emit) async {
    await _taskIsarRepository.UpdateUser(event.taskModel);
    emit(AddSuccessState());
  }
}
