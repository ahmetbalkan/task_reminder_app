part of 'test_bloc.dart';

enum GetTaskStatus { initial, today, complete, all, search, empty, loading }

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends TestState {}

class AddSuccessState extends TestState {}

class GetAllTaskState extends TestState {
  String searchValue;

  GetAllTaskState(this.searchValue);
}

class GetCompleteTaskState extends TestState {
  String searchValue;

  GetCompleteTaskState(this.searchValue);
}

class GetTodayTaskState extends TestState {
  String searchValue;
  GetTodayTaskState(this.searchValue);
}

class EditTestState extends TestState {
  final TaskModel updateTask;
  EditTestState({required this.updateTask});
}
