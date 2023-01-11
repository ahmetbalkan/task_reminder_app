import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  String? title;
  int? desc;
  DateTime? dateTimeNow;
  DateTime? dateTimeFinish;
  String category;
  int priority;

  UserModel(this.title, this.desc, this.dateTimeNow, this.dateTimeFinish,
      this.category, this.priority);
}
