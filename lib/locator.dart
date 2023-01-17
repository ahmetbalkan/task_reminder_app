import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_reminder_app/repository/category_isar_repository.dart';
import 'package:task_reminder_app/repository/task_isar_repository.dart';
import 'package:task_reminder_app/repository/user_isar_repository.dart';

import 'repository/setting_isar_repository.dart';

final locator = GetIt.I;

void locatorMethod() async {
  locator.registerLazySingleton(() => TaskIsarRepository());
  locator.registerLazySingleton(() => CategoryIsarRepository());
  locator.registerLazySingleton(() => SettingIsarRepository());
  locator.registerLazySingleton(() => UserIsarRepository());
}
