import 'package:isar/isar.dart';

import 'package:task_reminder_app/repository/opendb.dart';

import '../model/category.dart';
import '../model/user.dart';

class UserIsarRepository extends OpenDB {
  late Future<Isar> _db;
  UserIsarRepository() {
    _db = openDB();
  }

  Stream<List<UserModel>> listenUser() async* {
    final isar = await _db;
    yield* isar.userModels.where().watch(fireImmediately: true);
  }

  Future<void> saveUser(UserModel newUser) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.userModels.putSync(newUser));
  }

  Future<UserModel?> getSingle(int id) async {
    final isar = await _db;
    return isar.userModels.getSync(id);
  }

  Future<void> updateUser(UserModel user) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.userModels.put(user);
    });
  }

  Future<UserModel?> getFirstUser() async {
    final isar = await _db;
    return isar.userModels.getSync(1);
  }

  Future<void> deleteUser(int userid) async {
    final isar = await _db;
    isar.writeTxn(() => isar.userModels.delete(userid));
  }

  Future<void> cleanSettingDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.userModels.clear());
  }

  Future<List<UserModel>> getAllUser() async {
    final isar = await _db;
    return await isar.userModels.where().findAll();
  }
}
