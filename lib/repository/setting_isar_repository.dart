import 'package:isar/isar.dart';
import 'package:task_reminder_app/model/settings.dart';
import 'package:task_reminder_app/model/task.dart';
import 'package:task_reminder_app/repository/opendb.dart';

class SettingIsarRepository extends OpenDB {
  late Future<Isar> _db;
  SettingIsarRepository() {
    _db = openDB();
  }

  Stream<List<SettingsModel>> listenSetting() async* {
    final isar = await _db;
    yield* isar.settingsModels.where().watch(fireImmediately: true);
  }

  Future<void> saveSetting(SettingsModel newSetting) async {
    final isar = await _db;
    isar.writeTxnSync(() => isar.settingsModels.putSync(newSetting));
  }

  Future<void> cleanSettingDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.settingsModels.clear());
  }

  Future<SettingsModel?> getFirstSettings() async {
    final isar = await _db;
    return isar.settingsModels.getSync(1);
  }

  Future<void> UpdateSettings(SettingsModel settings) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.settingsModels.put(settings);
    });
  }
}
