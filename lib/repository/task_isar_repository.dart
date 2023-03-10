import 'dart:async';

import 'package:isar/isar.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/opendb.dart';

class TaskIsarRepository extends OpenDB {
  late Future<Isar> _db;
  TaskIsarRepository() {
    _db = openDB();
  }

  StreamController<List<TaskModel>> controller =
      StreamController<List<TaskModel>>();

  Stream<List<TaskModel>> listenFullTask() async* {
    final isar = await _db;
    yield* isar.taskModels
        .filter()
        .titleContains("")
        .watch(fireImmediately: true);
  }

  Stream<List<TaskModel>> listenAllUserTask(String value) async* {
    final isar = await _db;
    yield* isar.taskModels
        .filter()
        .completeEqualTo(false)
        .titleContains(value)
        .watch(fireImmediately: true);
  }

  Stream<List<TaskModel>> listenCompleteTask(String value) async* {
    final isar = await _db;
    yield* isar.taskModels
        .filter()
        .completeEqualTo(true)
        .titleContains(value)
        .watch(fireImmediately: true);
  }

  Future<void> completeTask(TaskModel user) async {
    final isar = await _db;
    user.complete = true;
    await isar.writeTxn(() async {
      await isar.taskModels.put(user);
    });
  }

  Stream<List<TaskModel>> listenTodayTask(String value) async* {
    final now = DateTime.now();
    final isar = await _db;
    yield* isar.taskModels
        .filter()
        .startDateBetween(DateTime(now.year, now.month, now.day, 00, 00, 01),
            DateTime(now.year, now.month, now.day, 23, 59, 59))
        .completeEqualTo(false)
        .titleContains(value)
        .watch(fireImmediately: true);
  }

  Future<void> saveUser(TaskModel newUser) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.taskModels.putSync(newUser));
  }

  Future<List<TaskModel>> getAllTask() async {
    final isar = await _db;
    return await isar.taskModels.where().findAll();
  }

  Future<List<TaskModel>> getCompleteTask() async {
    final isar = await _db;
    var value = await isar.taskModels.filter().completeEqualTo(true).findAll();
    return value;
  }

  Future<List<TaskModel>> searchTask(String search) async {
    final isar = await _db;
    var value = await isar.taskModels.filter().titleContains(search).findAll();
    return value;
  }

  Future<TaskModel?> getSingle(int id) async {
    final isar = await _db;
    return isar.taskModels.getSync(id);
  }

  Future<void> UpdateUser(TaskModel user) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.taskModels.put(user);
    });
  }

  Future<void> deleteUser(int userid) async {
    final isar = await _db;
    isar.writeTxn(() => isar.taskModels.delete(userid));
  }

  Future<void> cleanSettingDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.taskModels.clear());
  }
}
