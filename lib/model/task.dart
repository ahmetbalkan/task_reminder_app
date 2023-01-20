import 'package:isar/isar.dart';
part 'task.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;
  String? title;
  String? desc;
  DateTime? startDate;
  DateTime? EndDate;
  int? categoryid;
  int? priority;
  bool? alarm;
  bool? complete;

  TaskModel(this.title, this.desc, this.startDate, this.EndDate,
      this.categoryid, this.priority, this.alarm, this.complete);
}
