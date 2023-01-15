import 'package:isar/isar.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/opendb.dart';

class TaskIsarRepository extends OpenDB {
  late Future<Isar> _db;
  TaskIsarRepository() {
    _db = openDB();
  }

  Stream<List<TaskModel>> listenUser() async* {
    final isar = await _db;
    yield* isar.taskModels.where().watch(fireImmediately: true);
  }

  Future<void> saveUser(TaskModel newUser) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.taskModels.putSync(newUser));
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
}
