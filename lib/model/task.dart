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
  String? categoryName;
  int? categoryColor;
  int? priority;
  bool? complete;

  TaskModel(
      this.title,
      this.desc,
      this.startDate,
      this.EndDate,
      this.categoryid,
      this.categoryName,
      this.categoryColor,
      this.priority,
      this.complete);
}
