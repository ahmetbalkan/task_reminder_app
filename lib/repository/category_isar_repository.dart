import 'package:isar/isar.dart';

import 'package:task_reminder_app/repository/opendb.dart';

import '../model/category.dart';

class CategoryIsarRepository extends OpenDB {
  late Future<Isar> _db;
  CategoryIsarRepository() {
    _db = openDB();
  }

  Stream<List<CategoryModel>> listenCategory() async* {
    final isar = await _db;
    yield* isar.categoryModels.where().watch(fireImmediately: true);
  }

  Future<void> saveCategory(CategoryModel newUser) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.categoryModels.putSync(newUser));
  }

  Future<CategoryModel?> getSingle(int id) async {
    final isar = await _db;
    return isar.categoryModels.getSync(id);
  }

  Future<void> updateCategory(CategoryModel user) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.categoryModels.put(user);
    });
  }

  Future<void> deleteCategory(int userid) async {
    final isar = await _db;
    isar.writeTxn(() => isar.categoryModels.delete(userid));
  }
}
