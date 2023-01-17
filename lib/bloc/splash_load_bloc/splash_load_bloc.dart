import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/model/category.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';
import 'package:task_reminder_app/repository/setting_isar_repository.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/repository/user_isar_repository.dart';

import '../../locator.dart';
part 'splash_load_event.dart';
part 'splash_load_state.dart';

class SplashLoadBloc extends Bloc<SplashLoadEvent, SplashLoadState> {
  final _taskIsarRepository = locator.get<TaskIsarRepository>();
  final _settingIsarRepository = locator.get<SettingIsarRepository>();
  final _categoryIsarRepository = locator.get<CategoryIsarRepository>();
  final _userIsarRepository = locator.get<UserIsarRepository>();

  SplashLoadBloc() : super(const SplashLoadState()) {
    on<GetSplashLoadEvent>(_getSplashLoad);
    on<GetSplashChangeSettingsEvent>(_changeSettings);
  }

  _getSplashLoad(
      GetSplashLoadEvent event, Emitter<SplashLoadState> emit) async {
    var task = await _taskIsarRepository.getAllTask();
    var category = await _categoryIsarRepository.getAllCategory();
    var user = await _userIsarRepository.getAllUser();
    var settings = await _settingIsarRepository.getFirstSettings();
    emit(SplashLoadState(postStatus: PostStatus.loading));

    if (settings == null) {
      await _settingIsarRepository
          .saveSetting(SettingsModel(false, false, false, false));
    }
    settings = await _settingIsarRepository.getFirstSettings();

    if (settings != null) {
      if (settings.introComplete == false) {
        emit(const SplashLoadState(postStatus: PostStatus.showintro));
      } else {
        if (user.isEmpty) {
          emit(const SplashLoadState(postStatus: PostStatus.gologin));
        } else {
          if (user.first.isLogin == true) {
            if (settings.userInformationComplete == true) {
              emit(const SplashLoadState(postStatus: PostStatus.gohome));
            } else {
              emit(const SplashLoadState(postStatus: PostStatus.goinformation));
            }
          } else {
            emit(const SplashLoadState(postStatus: PostStatus.gologin));
          }
        }
      }
      if (category.isEmpty) {
        if (settings.categoryLoadComplete == false) {
          _categoryIsarRepository.saveAllCategory([
            // var iconData = IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons');
            CategoryModel("home-icon".tr(), 0xFFFFCC80, Icons.house.codePoint),
            CategoryModel("code-icon".tr(), 0xFFCCFF80, Icons.code.codePoint),
            CategoryModel("cases-icon".tr(), 0xFFFF9680, Icons.cases.codePoint),
            CategoryModel("sports_martial_arts-icon".tr(), 0xFF80FFFF,
                Icons.sports_martial_arts.codePoint),
            CategoryModel("crop-icon".tr(), 0xFF80FFFF, Icons.crop.codePoint),
            CategoryModel(
                "school-icon".tr(), 0xFF809CFF, Icons.school.codePoint),
            CategoryModel("Social", 0xFFFF80EB, Icons.people.codePoint),
            CategoryModel(
                "music_note-icon".tr(), 0xFFFC80FF, Icons.music_note.codePoint),
            CategoryModel("health_and_safety-icon".tr(), 0xFF80FFA3,
                Icons.health_and_safety.codePoint),
            CategoryModel("video_collection_rounded-icon".tr(), 0xFF80D1FF,
                Icons.video_collection_rounded.codePoint),
          ]);
          await _settingIsarRepository.updateCategoryLoad(true);
        }
      }
      if (task.isEmpty) {
        //TODO get list from api
        _settingIsarRepository.updateTaskLoad(true);
      }
    }
  }

  _changeSettings(
      GetSplashChangeSettingsEvent event, Emitter<SplashLoadState> emit) async {
    _settingIsarRepository.updateIntroRow(true);
  }
}
