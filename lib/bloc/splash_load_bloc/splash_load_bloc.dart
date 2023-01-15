import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/view/main_page.dart';

import '../../locator.dart';
part 'splash_load_event.dart';
part 'splash_load_state.dart';

class SplashLoadBloc extends Bloc<SplashLoadEvent, SplashLoadState> {
  final _taskIsarRepository = locator.get<TaskIsarRepository>();
  final _settingIsarRepository = locator.get<TaskIsarRepository>();
  final _categoryIsarRepository = locator.get<TaskIsarRepository>();

  SplashLoadBloc() : super(const SplashLoadState()) {
    on<getSplashLoadEvent>(_getSplashLoad);
  }

  _getSplashLoad(getSplashLoadEvent event, Emitter<SplashLoadState> emit) {
    var taskLenght = _taskIsarRepository.listenUser().length;
  }
}
