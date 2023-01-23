import 'dart:async';
import 'dart:math';

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

  final String dropDownValue;

  TestBloc(this.dropDownValue) : super(TestInitial()) {
    on<AddTestEvent>(_addTask);

    on<DeleteTaskEvent>(_deleteTaskEvent);
    on<EditTestEvent>(_editTaskEvent);
    on<UpdateTestEvent>(_updateTestEvent);
    on<AllTaskEvent>(_allTaskEvent);
    on<AllTaskEventUpdateEvent>(_allTaskUpdateEvent);
    on<CompleteTaskEvent>(_completeTaskEvent);
    on<CompleteTaskUpdateEvent>(_completeTaskUpdateEvent);
    on<TodayTaskEvent>(_todayTaskEvent);
    on<TodayTaskUpdateEvent>(_todayTaskUpdateEvent);
    on<SearchTaskEvent>(_searchTaskEvent);
    on<SearchTaskUpdateEvent>(_searchTaskUpdateEvent);
    on<UpdateButtonTaskEvent>(_updateButtonCompleteTaskEvent);
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

    switch (event.dropDownValue) {
      case "Tümünü Göster":
        _taskIsarRepository.listenAllUserTask("").listen((taskModel) {
          add((SearchTaskUpdateEvent(
              updatedlist: taskModel, dropDownValue: event.dropDownValue)));
        });

        break;
      case "Tamamlandı":
        _taskIsarRepository.listenCompleteTask("").listen((taskModel) {
          add((SearchTaskUpdateEvent(
              updatedlist: taskModel, dropDownValue: event.dropDownValue)));
        });

        break;
      case "Bu Gün":
        _taskIsarRepository.listenTodayTask("").listen((taskModel) {
          print(taskModel.length);
          add((SearchTaskUpdateEvent(
              updatedlist: taskModel, dropDownValue: event.dropDownValue)));
        });

        break;

      default:
    }
  }

  _updateButtonCompleteTaskEvent(
      UpdateButtonTaskEvent event, Emitter<TestState> emit) {
    event.updatedTask.complete == true;
    _taskIsarRepository.completeTask(event.updatedTask);
    emit(TestInitial());
  }

  _updateTestEvent(UpdateTestEvent event, Emitter<TestState> emit) async {
    await _taskIsarRepository.UpdateUser(event.taskModel);
    emit(AddSuccessState());
  }

  _allTaskEvent(AllTaskEvent event, Emitter<TestState> emit) async {
    _taskIsarRepository
        .listenAllUserTask(event.searchValue)
        .listen((taskModel) {
      add((AllTaskEventUpdateEvent(
          updatedlist: taskModel, dropDownValue: "Tümünü Göster")));
    });
  }

  _allTaskUpdateEvent(AllTaskEventUpdateEvent event, Emitter<TestState> emit) {
    emit(AllTaskState(
        tasklist: event.updatedlist, DropDownValue: event.dropDownValue));
  }

  _completeTaskEvent(CompleteTaskEvent event, Emitter<TestState> emit) {
    _taskIsarRepository
        .listenCompleteTask(event.searchValue)
        .listen((taskModel) {
      add((CompleteTaskUpdateEvent(
          updatedlist: taskModel, dropDownValue: "Tamamlandı")));
    });
  }

  _completeTaskUpdateEvent(
      CompleteTaskUpdateEvent event, Emitter<TestState> emit) {
    emit(CompleteTaskState(
        tasklist: event.updatedlist, DropDownValue: event.dropDownValue));
  }

  _todayTaskEvent(TodayTaskEvent event, Emitter<TestState> emit) {
    _taskIsarRepository.listenTodayTask(event.searchValue).listen((taskModel) {
      add((TodayTaskUpdateEvent(
          updatedlist: taskModel, dropDownValue: "Bu Gün")));
    });
  }

  _todayTaskUpdateEvent(TodayTaskUpdateEvent event, Emitter<TestState> emit) {
    emit(TodayTaskState(
        tasklist: event.updatedlist, DropDownValue: event.dropDownValue));
  }

  _searchTaskEvent(SearchTaskEvent event, Emitter<TestState> emit) {
    switch (event.dropDownValue) {
      case "Tümünü Göster":
        if (event.searchValue == "") {
          add(AllTaskEvent(dropDownValue: "Tümünü Göster", searchValue: ""));
        } else {
          emit(TestInitial());
          _taskIsarRepository
              .listenAllUserTask(event.searchValue)
              .listen((taskModel) {
            add((SearchTaskUpdateEvent(
                updatedlist: taskModel, dropDownValue: event.dropDownValue)));
          });
        }

        break;
      case "Tamamlandı":
        if (event.searchValue == "") {
          add(CompleteTaskEvent(dropDownValue: "Tamamlandı", searchValue: ""));
        } else {
          emit(TestInitial());
          _taskIsarRepository
              .listenCompleteTask(event.searchValue)
              .listen((taskModel) {
            add((SearchTaskUpdateEvent(
                updatedlist: taskModel, dropDownValue: event.dropDownValue)));
          });
        }
        break;
      case "Bu Gün":
        if (event.searchValue == "") {
          add(TodayTaskEvent(dropDownValue: "Bu Gün", searchValue: ""));
        } else {
          emit(TestInitial());
          _taskIsarRepository
              .listenTodayTask(event.searchValue)
              .listen((taskModel) {
            print(taskModel.length);
            add((SearchTaskUpdateEvent(
                updatedlist: taskModel, dropDownValue: event.dropDownValue)));
          });
        }

        break;

      default:
    }
  }

  _searchTaskUpdateEvent(SearchTaskUpdateEvent event, Emitter<TestState> emit) {
    emit(SearchTaskState(tasklist: event.updatedlist));
  }
}
