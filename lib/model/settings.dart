import 'package:isar/isar.dart';
part 'settings.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement;
  bool introComplete;
  bool userInformationComplete;
  bool categoryLoadComplete;
  bool taskLoadComplete;

  SettingsModel(this.introComplete, this.userInformationComplete,
      this.categoryLoadComplete, this.taskLoadComplete);
}
