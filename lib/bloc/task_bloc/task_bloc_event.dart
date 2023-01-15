part of 'task_bloc_bloc.dart';

abstract class TaskBlocEvent extends Equatable {
  const TaskBlocEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskBlocEvent {
  final TaskModel taskModel;
  const AddTaskEvent({required this.taskModel});
}

class DeleteTaskEvent extends TaskBlocEvent {
  final int id;
  const DeleteTaskEvent(this.id);
}
