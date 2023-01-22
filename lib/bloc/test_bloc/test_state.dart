part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends TestState {}

class EmptyListState extends TestState {}

class AddSuccessState extends TestState {}

class EditTestState extends TestState {
  final TaskModel updateTask;

  EditTestState({
    required this.updateTask,
  });
}

class AllTaskState extends TestState {
  final List<TaskModel> tasklist;
  final String DropDownValue;
  AllTaskState({required this.tasklist, required this.DropDownValue});
}

class CompleteTaskState extends TestState {
  final List<TaskModel> tasklist;
  final String DropDownValue;
  CompleteTaskState({required this.tasklist, required this.DropDownValue});
}

class TodayTaskState extends TestState {
  final List<TaskModel> tasklist;
  final String DropDownValue;
  TodayTaskState({required this.tasklist, required this.DropDownValue});
}

class SearchTaskState extends TestState {
  final List<TaskModel> tasklist;

  SearchTaskState({required this.tasklist});
}
