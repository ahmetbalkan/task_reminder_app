part of 'task_bloc_bloc.dart';

abstract class TaskBlocState extends Equatable {
  const TaskBlocState();
  
  @override
  List<Object> get props => [];
}

class TaskBlocInitial extends TaskBlocState {}
