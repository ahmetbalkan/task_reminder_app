import 'package:isar/isar.dart';
part 'task.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;
  String? title;
  String? desc;
  DateTime? dateTimeNow;
  DateTime? dateTimeFinish;
  int? categoryid;
  int? priority;
  bool? alarm;

  TaskModel(this.title, this.desc, this.dateTimeNow, this.dateTimeFinish,
      this.categoryid, this.priority, this.alarm);
}
