import 'package:isar/isar.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/model/user.dart';

class TaskIsarRepository {
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [SettingsModelSchema, TaskModelSchema, UserModelSchema],
      );
    }
    return Future.value(Isar.getInstance());
  }
}
