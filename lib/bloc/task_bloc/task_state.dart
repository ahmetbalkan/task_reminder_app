part of 'task_bloc.dart';

enum PostStatus { initial, success, failure }

enum GetTaskStatus { initial, today, complete, all, search, empty, loading }

class TaskBlocState extends Equatable {
  final String errorText;
  final PostStatus postStatus;
  final GetTaskStatus getTaskStatus;
  final bool alarmStatus;
  List<TaskModel>? tasks;

  TaskBlocState(
      {this.errorText = "",
      this.postStatus = PostStatus.initial,
      this.getTaskStatus = GetTaskStatus.initial,
      this.alarmStatus = false,
      this.tasks = const []});

  @override
  List<Object> get props => [errorText, postStatus];

  TaskBlocState copyWith({
    String? errorText,
    PostStatus? postStatus,
    GetTaskStatus? getTaskStatus,
    bool? alarmStatus,
    List<TaskModel>? tasks,
  }) {
    return TaskBlocState(
      errorText: errorText ?? this.errorText,
      postStatus: postStatus ?? this.postStatus,
      getTaskStatus: getTaskStatus ?? this.getTaskStatus,
      alarmStatus: alarmStatus ?? this.alarmStatus,
      tasks: tasks ?? this.tasks,
    );
  }
}
