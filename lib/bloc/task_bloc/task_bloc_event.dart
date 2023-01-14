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
  const DeleteTaskEvent({required this.id});
}

class UpdateTaskEvent extends TaskBlocEvent {}

class GetSingleEvent extends TaskBlocEvent {}

class ErrorTextEvent extends TaskBlocEvent {}
