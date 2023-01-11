import 'package:isar/isar.dart';
part 'settings.g.dart';

@collection
class SettingsModel {
  Id id = Isar.autoIncrement;
  bool? introComplete;
  bool? userInformationComplete;

  SettingsModel(this.introComplete, this.userInformationComplete);
}
