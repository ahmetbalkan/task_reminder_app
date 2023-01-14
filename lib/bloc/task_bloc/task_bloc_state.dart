part of 'task_bloc_bloc.dart';

abstract class TaskBlocState extends Equatable {
  const TaskBlocState();

  @override
  List<Object> get props => [];
}

class TaskBlocInitial extends TaskBlocState {}

class LoadingTaskState extends TaskBlocState {}

class GetAllTaskState extends TaskBlocState {
  List<TaskModel> taskModelList;

  GetAllTaskState({required this.taskModelList});
}

class ErrorTextState extends TaskBlocState {
  final String errorText;

  const ErrorTextState({required this.errorText});
}

class TaskAddedState extends TaskBlocState {}
