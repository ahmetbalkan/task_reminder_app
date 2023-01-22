part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class GetAllTaskEvent extends TestEvent {
  String seachValue;

  GetAllTaskEvent({required this.seachValue});
}

class GetCompleteTaskEvent extends TestEvent {
  String seachValue;

  GetCompleteTaskEvent({required this.seachValue});
}

class GetTodayTaskEvent extends TestEvent {
  String seachValue;

  GetTodayTaskEvent({required this.seachValue});
}

class GetSearchTaskEvent extends TestEvent {
  String seachValue;

  GetSearchTaskEvent({required this.seachValue});
}

class DeleteTaskEvent extends TestEvent {
  final int id;
  const DeleteTaskEvent(this.id);
}

class AddTestEvent extends TestEvent {
  final TaskModel taskModel;
  const AddTestEvent({required this.taskModel});
}

class EditTestEvent extends TestEvent {
  final TaskModel taskModel;
  const EditTestEvent({required this.taskModel});
}

class UpdateTestEvent extends TestEvent {
  final TaskModel taskModel;
  const UpdateTestEvent({required this.taskModel});
}
