import 'package:isar/isar.dart';
part 'task.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;
  String? title;
  int? desc;
  DateTime? dateTimeNow;
  DateTime? dateTimeFinish;
  String category;
  int priority;

  TaskModel(this.title, this.desc, this.dateTimeNow, this.dateTimeFinish,
      this.category, this.priority);
}
