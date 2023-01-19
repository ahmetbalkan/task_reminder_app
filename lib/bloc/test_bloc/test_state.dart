part of 'test_bloc.dart';

enum PostStatus { initial, success, failure }

enum GetTaskStatus { initial, today, complete, all, search, empty, loading }

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends TestState {}

class GetAllTaskState extends TestState {
  List<TaskModel> allTask;
  String name;

  GetAllTaskState({required this.allTask, required this.name});
}

class GetCompleteTaskState extends TestState {
  List<TaskModel> completeTask;
  String name;

  GetCompleteTaskState({required this.completeTask, required this.name});
}

class GetSearchTaskState extends TestState {
  List<TaskModel> searchTask;
  String name;

  GetSearchTaskState({required this.searchTask, required this.name});
}

class TestVerbState extends TestState {
  final String errorText;
  final PostStatus postStatus;
  final GetTaskStatus getTaskStatus;
  final bool alarmStatus;
  List<TaskModel>? tasks;

  TestVerbState(
      {this.errorText = "",
      this.postStatus = PostStatus.initial,
      this.getTaskStatus = GetTaskStatus.initial,
      this.alarmStatus = false,
      this.tasks = const []});

  @override
  List<Object> get props => [errorText, postStatus];

  TestVerbState copyWith({
    String? errorText,
    PostStatus? postStatus,
    GetTaskStatus? getTaskStatus,
    bool? alarmStatus,
    List<TaskModel>? tasks,
  }) {
    return TestVerbState(
      errorText: errorText ?? this.errorText,
      postStatus: postStatus ?? this.postStatus,
      getTaskStatus: getTaskStatus ?? this.getTaskStatus,
      alarmStatus: alarmStatus ?? this.alarmStatus,
      tasks: tasks ?? this.tasks,
    );
  }
}
