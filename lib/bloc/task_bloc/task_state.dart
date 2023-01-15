part of 'task_bloc.dart';

enum PostStatus { initial, success, failure }

class TaskBlocState extends Equatable {
  final String errorText;
  final PostStatus postStatus;
  final bool alarmStatus;

  const TaskBlocState(
      {this.errorText = "",
      this.postStatus = PostStatus.initial,
      this.alarmStatus = false});

  @override
  List<Object> get props => [errorText, postStatus];

  TaskBlocState copyWith({
    String? errorText,
    PostStatus? postStatus,
    bool? alarmStatus,
  }) {
    return TaskBlocState(
      errorText: errorText ?? this.errorText,
      postStatus: postStatus ?? this.postStatus,
      alarmStatus: alarmStatus ?? this.alarmStatus,
    );
  }
}
