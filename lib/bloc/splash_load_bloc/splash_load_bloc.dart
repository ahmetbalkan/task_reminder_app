import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';
import 'package:task_reminder_app/repository/setting_isar_repository.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/repository/user_isar_repository.dart';
import 'package:task_reminder_app/view/main_page.dart';

import '../../locator.dart';
part 'splash_load_event.dart';
part 'splash_load_state.dart';

class SplashLoadBloc extends Bloc<SplashLoadEvent, SplashLoadState> {
  final _taskIsarRepository = locator.get<TaskIsarRepository>();
  final _settingIsarRepository = locator.get<SettingIsarRepository>();
  final _categoryIsarRepository = locator.get<CategoryIsarRepository>();
  final _userIsarRepository = locator.get<UserIsarRepository>();

  SplashLoadBloc() : super(const SplashLoadState()) {
    on<getSplashLoadEvent>(_getSplashLoad);
  }

  _getSplashLoad(
      getSplashLoadEvent event, Emitter<SplashLoadState> emit) async {
    var task = await _taskIsarRepository.getAllTask();
    var category = await _categoryIsarRepository.getAllCategory();
    var user = await _userIsarRepository.getFirstUser();
    var settings = await _settingIsarRepository.getFirstSettings();

    if (task.isEmpty) {
      emit(SplashLoadState(postStatus: PostStatus.loading));
      //TODO get list from api
    }
    if (category.isEmpty) {
      _categoryIsarRepository.saveAllCategory([
        // var iconData = IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons');
        CategoryModel("Developer", 0xFFCCFF80, FontAwesomeIcons.code.codePoint),
        CategoryModel("Work", 0xFFFF9680, FontAwesomeIcons.briefcase.codePoint),
        CategoryModel("Sport", 0xFF80FFFF, FontAwesomeIcons.dumbbell.codePoint),
        CategoryModel("Design", 0xFF80FFFF, FontAwesomeIcons.crop.codePoint),
        CategoryModel(
            "University", 0xFF809CFF, FontAwesomeIcons.school.codePoint),
        CategoryModel(
            "Social", 0xFFFF80EB, FontAwesomeIcons.thumbsUp.codePoint),
        CategoryModel("Music", 0xFFFC80FF, FontAwesomeIcons.music.codePoint),
        CategoryModel(
            "Health", 0xFF80FFA3, FontAwesomeIcons.kitMedical.codePoint),
        CategoryModel("Movie", 0xFF80D1FF, FontAwesomeIcons.video.codePoint),
        CategoryModel("Home", 0xFFFFCC80, FontAwesomeIcons.house.codePoint),
      ]);
    }
    if (settings == null) {
      _settingIsarRepository.saveSetting(SettingsModel(false, false));
    } else {
      if (settings.introComplete == false) {
        emit(const SplashLoadState(postStatus: PostStatus.showintro));
      } else {
        if (user == null) {
          emit(const SplashLoadState(postStatus: PostStatus.gologin));
        } else {
          if (user.isLogin == true) {
            if (settings.userInformationComplete == true) {
              emit(const SplashLoadState(postStatus: PostStatus.gohome));
            } else {
              emit(const SplashLoadState(postStatus: PostStatus.goinformation));
            }
          }
        }
      }
    }
  }

  /* enum PostStatus {
  initial,
  showintro,
  gologin,
  gohome,
}*/

}
