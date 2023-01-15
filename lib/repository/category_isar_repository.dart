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

  Future<List<CategoryModel>> getAllCategory() async {
    final isar = await _db;
    return await isar.categoryModels.where().findAll();
  }

  Future<void> saveCategory(CategoryModel categoryModel) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.categoryModels.putSync(categoryModel));
  }

  Future<void> saveAllCategory(List<CategoryModel> categoryModel) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.categoryModels.putAllSync(categoryModel));
  }

  Future<void> cleanSettingDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.categoryModels.clear());
  }

  Future<void> UpdateCategory(CategoryModel categoryModel) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.categoryModels.put(categoryModel);
    });
  }
}
