import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/model/user.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<PremiumCheckEvent>(_userPremumCheckEvent);
  }

  _userPremumCheckEvent(PremiumCheckEvent event, Emitter<GroupState> emit) {
    print(PremiumCheckEvent);
    emit(GroupLoading());
    emit(PremiumCheckState(groupID: "123123213", isPremium: true, userList: [
      UserModel(true, "userName", "userkey", true,
          "https://api.lorem.space/image/face?w=150&h=150"),
      UserModel(true, "userName", "userkey", true,
          "https://api.lorem.space/image/face?w=150&h=151"),
      UserModel(true, "userName", "userkey", true,
          "https://api.lorem.space/image/face?w=150&h=152"),
    ], taskList: <TaskModel>[
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
      TaskModel(
          "title",
          "desc",
          DateTime.now().add(Duration(hours: 2)),
          DateTime.now().add(Duration(days: 2)),
          2,
          "Developer",
          Colors.red.hashCode,
          5,
          false),
    ]));
  }
}
